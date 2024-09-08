extends Node
#class_name Dice

# dice result of normal check
enum check_results {
	SUCCESS,
	FUMBLE,
	CRITICAL_SUCCESS,
	CRITICAL_FUMBLE,
}

# result of opposed check
enum opposed_winner {
	attacker,
	defender,
}

func roll(dice : String) -> int:
	if not dice_string_validation(dice):
		return 0
	var amount : int = dice.get_slice('d',0).to_int()
	var size : int = dice.get_slice('+',0).get_slice('d',1).to_int()
	var mod : int = dice.get_slice('+',1).to_int() if dice.split('+').size() > 1 else 0
	var total : int = mod
	for i in amount:
		var r = randi_range(1, size)
		total += r
	return total

func roll_seperately(dice : String) -> Array:
	if not dice_string_validation(dice):
		return []
	var result : Array = []
	var amount : int = dice.get_slice('d',0).to_int()
	var size : int = dice.get_slice('+',0).get_slice('d',1).to_int()
	for i in amount:
		result.push_back(roll("1d%d" % size)) # simply don't send the modifier to the roll
	return result

func to_damage(dice : String, critical : bool = false) -> int:
	if not dice_string_validation(dice):
		return 0
	var result : int = 0
	var amount : int = dice.get_slice('d',0).to_int()
	var size : int = dice.get_slice('+',0).get_slice('d',1).to_int()
	var mod : int = dice.get_slice('+',1).to_int() if dice.split('+').size() > 1 else 0
	if critical: # on crit, double amount of dice and double modifier
		amount += amount
		mod += mod
	var rolls = roll_seperately("%dd%d" % [amount, size])
	rolls.sort()
	rolls[0] += mod
	for roll in rolls:
		result += damage_table_conversion(roll)
	print("damage conversion: ")
	print("\trolls: ", rolls, " mod: %d result: %d crit: %s\n" % [mod, result, str(critical)])
	return result

# \d+d\d+(\+\d+)?
func dice_string_validation(dice : String) -> bool:
	var validation : RegEx
	validation = RegEx.create_from_string(r"\d+d\d+(\+\d+)?")
	var substr : RegExMatch = validation.search(dice)
	if substr == null:
		push_error("Invalid die string")
		return false
	return true

# die roll | damage dealt
#      1   | 0
#      2-4 | 1
#      5-7 | 2
#      8-9 | 3
#      10+ | 4
func damage_table_conversion(roll : int) -> int:
	if roll < 1:
		return 0
	match roll:
		1:
			return 0
		2, 3, 4:
			return 1
		5, 6, 7:
			return 2
		8, 9:
			return 3
		_:
			return 4

# advantage -- 0 for none, 1 for advantage, -1 for disadvantage
func roll_100(advantage : int):
	var a = randi_range(0,9)
	var b = randi_range(0,9)
	var roll : int
	var critical : bool = false
	if a == b: critical = true
	
	# special case for 100 
	if a == 0 and b == 0:
		roll = 100
	elif advantage == 0:
		roll = a * 10 + b
	elif advantage <= -1: # take higher number on disadvantage
		roll = (a * 10 + b) if (a > b) else (b * 10 + a)
	elif advantage >= 1: # take lower number on advantage
		roll = (a * 10 + b) if (a < b) else (b * 10 + a)
	return {
		"roll" = roll,
		"critical" = critical,
	}

func check(values : CheckValue) -> CheckResult:
	var r = roll_100(values.advantage)
	var result = interprete_check(r, values)
	print("\troll: %d stat: %d success: %s critical: %s" % [r.roll, values.attribute_value, str(result.success), str(result.critical)])
	return result

func interprete_check(roll : Dictionary, values : CheckValue) -> CheckResult:
	var result : CheckResult = CheckResult.new()
	if roll.critical:
		result.critical = true
	else:
		result.critical = false
	if roll.roll <= values.attribute_value:
		result.success = true
	if roll.roll > values.attribute_value:
		result.success = false
	return result

# attacker and defender both roll 2d10 (d100)
# highest roll without going over skill limit wins
# on ties (two fumbles any value, two crit_fumbles any value, two success and tied roll)
	# highest skill point value wins
# I'm interpreting the rules to include crit_success beating regular success any values
# also giving attacker win on absolute ties
func opposed_check(atk_values : CheckValue, def_values : CheckValue):
	var attacker_roll = roll_100(atk_values.advantage) # need to keep track of actual roll values for runoffs
	var defender_roll = roll_100(def_values.advantage)
	var result : OpposedCheckResult = OpposedCheckResult.new(
		interprete_check(attacker_roll, atk_values),
		interprete_check(defender_roll, def_values),)
	# (A) both crit succeed or both normal succeed
	if (result.attacker_success and result.defender_success) and (result.defender_critical == result.attacker_critical):
		# higher die result wins
		if attacker_roll.roll > defender_roll.roll:
			result.winner = opposed_winner.attacker
		elif attacker_roll.roll < defender_roll.roll:
			result.winner = opposed_winner.defender
		# skill value runoff with attacker win after die ties
		elif atk_values.attribute_value >= def_values.attribute_value:
			result.winner = opposed_winner.attacker
		elif atk_values.attribute_value < def_values.attribute_value:
			result.winner = opposed_winner.defender
	
	# (B) both fumble
	elif not result.attacker_success and not result.defender_success:
		# one crit fumble and one normal fumble
		if result.attacker_critical and not result.defender_critical:
			result.winner = opposed_winner.defender
		elif not result.attacker_critical and result.defender_critical:
			result.winner = opposed_winner.attacker
		# stat value runoff of two fumbles or two crit fumbles
		elif atk_values.attribute_value == def_values.attribute_value: 
			result.winner = opposed_winner.attacker 
		elif atk_values.attribute_value > def_values.attribute_value:
			result.winner = opposed_winner.attacker
		elif atk_values.attribute_value < def_values.attribute_value: 
			result.winner = opposed_winner.defender
	
	# (C) one (crit or normal) success and one (crit or normal) fumble
	elif result.attacker_success and not result.defender_success:
		result.winner = opposed_winner.attacker
	elif not result.attacker_success and result.defender_success:
		result.winner = opposed_winner.defender
	
	# (D) double success single critical OVERRIDE!!!!
	elif (result.attacker_success and result.defender_success) and (result.attacker_critical != result.defender_critical) :
		if result.attacker_critical:
			result.winner = opposed_winner.attacker
		else:
			result.winner = opposed_winner.defender
	
	# fall-through attacker win
	else: 
		result.winner = opposed_winner.attacker
		push_warning("ERROR: opposed check result not handled correctly")
	print("\tattacker roll: %d stat: %d success: %s critical: %s" % [attacker_roll.roll, atk_values.attribute_value, str(result.attacker_success), str(result.attacker_critical)])
	print("\tdefender roll: %d stat: %d success: %s critical: %s" % [defender_roll.roll, def_values.attribute_value, str(result.defender_success), str(result.defender_critical)])
	print("\twinner: %s\n" % ("attacker" if  result.winner == 0 else "defender")) 
	return result
