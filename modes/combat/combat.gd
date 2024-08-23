extends Node
class_name Combat

var combat_actions = [
	Action.new(self, "standard attack", "standard attack"),
	Action.new(self, "flee", "flee"),
	Action.new(self, "pass", "pass"),
]

var stealth_actions = [
	Action.new(self, "attempt stealth", "attempt"),
	Action.new(self, "attack", "attack"),
]

var monsters = []
var player_initiative : bool = true
enum stealth_outcomes {
	none,
	success,
	failure
}
var stealth_result : stealth_outcomes = stealth_outcomes.none

func do_action(action_key : String):
	if action_key == "attempt":
		attempt_stealth()
		roll_initiative()
	elif action_key == "attack":
		roll_initiative()

func initialize(values : CombatValues):
	print("-combat starting-")
	add_monster(values.monster)
	if not values.player_surprised:
		stealth_check()

func add_monster(monster : Monster):
	for i in range(1, monster.number):
		monsters.push_back(monster)

func stealth_check():
	ActionSelection.list_actions(stealth_actions)

func attempt_stealth():
	var highest_awareness = 0
	for monster in monsters:
		if monster.awareness > highest_awareness:
			highest_awareness = monster.awareness
	var stealth_check_result = Dice.opposed_check(
		CheckValue.new(Character.skills.get_value("stealth")),
		CheckValue.new(highest_awareness)
	)
	if stealth_check_result.winner == Dice.opposed_winner.attacker:
		stealth_result = stealth_outcomes.success
	else:
		stealth_result = stealth_outcomes.failure

func roll_initiative():
	var character_perception = Character.skills.get_value("perception")
	var highest_awareness = 0
	for monster in monsters:
		if monster.awareness > highest_awareness:
			highest_awareness = monster.awareness
	if stealth_result == stealth_outcomes.failure:
		character_perception =- 10
	var roll_result : OpposedCheckResult = Dice.opposed_check(
		CheckValue.new(character_perception),
		CheckValue.new(highest_awareness),
	)
	if roll_result.winner == Dice.opposed_winner.attacker:
		print("player gets initiative")
		player_initiative = true
	else: 
		print("monster gets initiative")
		player_initiative = false
	return roll_result
