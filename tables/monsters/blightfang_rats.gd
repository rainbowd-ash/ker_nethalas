extends Monster
class_name BlightfangRats

var rally_counter = 0

func _init():
	title = "blightfang rats"
	number = 3
	awareness = 60
	endurance = 30
	athletics = 5
	health = 3
	combat_skill = 30
	magic_resistance = 20

func roll_attack():
	var action_roll = Dice.roll(1,"d6")
	if action_roll == 1 or action_roll == 2:
		bite()
	elif action_roll >= 3 and action_roll <= 5:
		scratch()
	elif action_roll == 6:
		rally()

func bite():
	SignalBus.chat_log.emit("%s bites" % title)
	var attack = Damage.new(Dice.to_damage(1, "d6", rally_counter), Damage.damage_types.piercing)
	attack.amount += rally_counter
	SignalBus.combat_attack.emit(CombatAttack.new(
		self,Character,attack)
	)

func scratch():
	SignalBus.chat_log.emit("%s scratches" % title)
	var attack = Damage.new(Dice.to_damage(1, "d4", 1 + rally_counter), Damage.damage_types.slashing)
	SignalBus.combat_attack.emit(CombatAttack.new(
		self,Character,attack)
	)

func rally():
	SignalBus.chat_log.emit("%s rallies" % title)
	for child in get_parent().get_children():
		if child is BlightfangRats:
			child.rally_counter += 1
