extends Monster
class_name BlightfangRats

var rally_counter = 0

func _init() -> void:
	title = "blightfang rats"
	number = 3
	awareness = 60
	endurance = 30
	athletics = 5
	max_health = 3
	combat_skill = 30
	magic_resistance = 20
	body_plan = BodyPlanQuadraped.new()
	weak_spots = ["head"]

func roll_attack():
	var action_roll = Dice.roll("1d6")
	if action_roll == 1 or action_roll == 2:
		bite()
	elif action_roll >= 3 and action_roll <= 5:
		scratch()
	elif action_roll == 6:
		rally()

func bite():
	SignalBus.chat_log.emit("%s bites" % title)
	var attack = Damage.new(Dice.to_damage("1d6+%d" % rally_counter), Damage.damage_types.piercing)
	attack.amount += rally_counter
	SignalBus.attack.emit(Attack.new(self, default_target, attack))

func scratch():
	SignalBus.chat_log.emit("%s scratches" % title)
	var attack = Damage.new(Dice.to_damage("1d4+%d" % (1 + rally_counter)), Damage.damage_types.slashing)
	SignalBus.attack.emit(Attack.new(self, default_target, attack))

func rally():
	SignalBus.chat_log.emit("%s rallies" % title)
	for child in get_parent().get_children():
		if child is BlightfangRats:
			child.rally_counter += 1
