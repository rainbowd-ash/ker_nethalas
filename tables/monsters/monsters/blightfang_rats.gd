extends Monster
class_name BlightfangRats

func _init():
	stat_block.title = "blightfang rats"
	stat_block.number = 3
	stat_block.awareness = 60
	stat_block.endurance = 30
	stat_block.athletics = 5
	stat_block.health = 3
	stat_block.combat_skill = 30
	stat_block.magic_resistance = 20

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
