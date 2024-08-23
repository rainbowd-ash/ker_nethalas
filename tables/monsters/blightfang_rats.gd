extends Monster
class_name BlightfangRats

func _init():
	title = "blightfang rats"
	number = 3
	awareness = 60
	endurance = 30
	athletics = 5
	health = 3
	combat_skill = 30
	magic_resistance = 20

func actions():
	var action_roll = Dice.roll(1,"d6")
	if action_roll == 1 or action_roll == 2:
		bite()
	if action_roll >= 3 and action_roll <= 5:
		scratch()
	if action_roll == 6:
		rally()

func bite():
	pass

func scratch():
	pass

func rally():
	pass
