extends Node

var combat_actions = [
	"standard_attack",
	"flee",
]

var combatants = []
var monster

func add_monster():
	monster = load("res://monsters/monsters/blightfang_rats.tscn").instantiate()
	monster.add_to_group("monsters")
	add_child(monster)
	# check number stat to add copies of monster

func roll_initiative():
	var roll_result : OpposedCheckResult = Dice.opposed_check(
		CheckValue.new(Character.skills.get_value("perception"), 0),
		CheckValue.new(monster.get_stat_value("awareness"), 0),
	)
	if roll_result.winner == Dice.opposed_winner.attacker:
		print("Player gets initiative")
	else: print("Monster gets initiative")
	return roll_result

func set_initiative_order(check_result : OpposedCheckResult):
	pass

func _ready():
	print("Combat Starting")
	add_monster()
	var initiative = roll_initiative()
	if initiative.winner == Dice.opposed_winner.attacker:
		player_action()
	else:
		monster_action()
	# handle crit fails on initiave roll
	pass

func player_action():
	print("player action")

func monster_action():
	print("monster action")
