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

const sizes = {
	"d4": 4,
	"d6": 6,
	"d8": 8,
	"d10": 10,
	"d12": 12,
	"d20": 20,
}

# (1, "d6", 4) = 1d6+4
func roll(quantity : int, type : String, modifier : int = 0):
	var total : int = modifier
	for i in quantity:
		total += randi_range(1, sizes[type])
	return total

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

func check(values : CheckValue):
	var r = roll_100(values.advantage)
	return interprete_check(r, values)

func interprete_check(roll : Dictionary, values : CheckValue):
	var result : InterpreteCheckResult = InterpreteCheckResult.new()
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
			return result
		if attacker_roll.roll < defender_roll.roll:
			result.winner = opposed_winner.defender
			return result
		# skill value runoff with attacker win after die ties
		if atk_values.attribute_value >= def_values.attribute_value:
			result.winner = opposed_winner.attacker
			return result
		if atk_values.attribute_value < def_values.attribute_value:
			result.winner = opposed_winner.defender
			return result
	
	# (B) both fumble
	if not result.attacker_success and not result.defender_success:
		# one crit fumble and one normal fumble
		if result.attacker_critical and not result.defender_critical:
			result.winner = opposed_winner.defender
			return result
		if not result.attacker_critical and result.defender_critical:
			result.winner = opposed_winner.attacker
			return result
		# stat value runoff of two fumbles or two crit fumbles
		if atk_values.attribute_value == def_values.attribute_value: 
			result.winner = opposed_winner.attacker 
			return result
		if atk_values.attribute_value > def_values.attribute_value:
			result.winner = opposed_winner.attacker
			return result
		if atk_values.attribute_value < def_values.attribute_value: 
			result.winner = opposed_winner.defender
			return result
	
	# (C) one (crit or normal) success and one (crit or normal) fumble
	if result.attacker_success and not result.defender_success:
		result.winner = opposed_winner.attacker
		return result
	if not result.attacker_success and result.defender_success:
		result.winner = opposed_winner.defender
		return result
	
	# fall-through attacker win
	result.winner = opposed_winner.attacker
	print("ERROR: opposed check result not handled correctly")
	return result
