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

func do_action():
	var action_roll = Dice.roll(1,"d6")
	if action_roll == 1 or action_roll == 2:
		bite()
	elif action_roll >= 3 and action_roll <= 5:
		scratch()
	elif action_roll == 6:
		rally()

func bite():
	SignalBus.chat_log.emit("%s bites" % title)
	var attack = Damage.new(Damage.damage_types.piercing, Dice.roll(1, "d6"))
	attack.amount += rally_counter
	SignalBus.combat_attack.emit(CombatAttack.new(
		self,get_parent().get_character_dummy(),attack)
	)

func scratch():
	SignalBus.chat_log.emit("%s scratches" % title)
	var attack = Damage.new(Damage.damage_types.slashing, Dice.roll(1, "d4", 1))
	attack.amount += rally_counter
	SignalBus.combat_attack.emit(CombatAttack.new(
		self,get_parent().get_character_dummy(),attack)
	)

func rally():
	SignalBus.chat_log.emit("%s rallies" % title)
	for child in get_parent().get_children():
		if child is BlightfangRats:
			child.rally_counter += 1
