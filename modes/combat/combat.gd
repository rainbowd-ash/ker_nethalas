extends Node
class_name Combat

signal player_round_finished
signal stealth_attempt_finished

var in_combat : bool = true
var monsters = []
var player_initiative : bool = true
var player_standard_actions : int = 1
var player_free_actions : int = 1
var initiative_mod = 0
var stealth_check_result : OpposedCheckResult = null

func _ready() -> void:
	Character.performed_standard_action.connect(_on_character_performed_standard_action)
	Character.performed_free_action.connect(_on_character_performed_free_action)

func do_action(action_key : String):
	if action_key == "attempt stealth":
		print("-sneak attack attempt-")
		attempt_stealth()
		stealth_attempt_finished.emit()
	elif action_key == "no stealth":
		print("\tpassed on sneak attack")
		stealth_attempt_finished.emit()
	elif action_key == "free action":
		list_free_actions()
	elif action_key == "standard action":
		list_standard_actions()
	elif action_key == "pass":
		player_round_finished.emit()
	elif action_key == "actions_back":
		list_combat_actions()
	elif action_key == "flee":
		in_combat = false
		player_round_finished.emit()

func initialize(values : CombatSetupValues):
	print("-combat starting-\n")
	add_monster(values.monster)
	if not values.player_surprised:
		list_stealth_actions()
		await stealth_attempt_finished
	roll_initiative()
	combat_rounds()

func combat_rounds():
	if not player_initiative and in_combat:
		monster_action()
		player_initiative = true
	while in_combat:
		if in_combat:
			player_action()
			await player_round_finished
		if in_combat:
			monster_action()
		# refresh actions
		player_standard_actions = 1
		player_free_actions = 1
	if not in_combat:
		end_combat()

func add_monster(monster : Monster):
	for i in range(0, monster.number):
		monsters.push_back(monster)

func attempt_stealth():
	var highest_awareness = 0
	for monster in monsters:
		if monster.awareness > highest_awareness:
			highest_awareness = monster.awareness
	stealth_check_result = Dice.opposed_check(
		CheckValue.new(Character.skills.get_value("stealth")),
		CheckValue.new(highest_awareness)
	)
	if stealth_check_result.winner == Dice.opposed_winner.defender:
		initiative_mod -= 10

func roll_initiative():
	# TODO handle crit failure
	print("-initiative roll-")
	if stealth_check_result:
		if stealth_check_result.winner == Dice.opposed_winner.attacker:
			print("player gets initiative from stealth success")
			player_initiative = true
			return
	var character_perception : int = Character.skills.get_value("perception")
	var highest_awareness = 0
	for monster in monsters:
		if monster.awareness > highest_awareness:
			highest_awareness = monster.awareness
	var roll_result : OpposedCheckResult = Dice.opposed_check(
		CheckValue.new(character_perception + initiative_mod),
		CheckValue.new(highest_awareness),
	)
	if roll_result.winner == Dice.opposed_winner.attacker:
		print("player gets initiative")
		player_initiative = true
	else: 
		print("monster gets initiative")
		player_initiative = false

func monster_action():
	for monster in monsters:
		print("monster action!")

func player_action():
	list_combat_actions()
	print("player action!")

func list_stealth_actions():
	ActionSelection.list_actions([
		Action.new(self, "attempt stealth", "go for a sneak attack"),
		Action.new(self, "no stealth", "run in and attack"),
		])

func list_combat_actions():
	var combat_actions = [
		Action.new(self, "pass"),
	]
	if bool(player_free_actions):
		combat_actions.push_front(Action.new(self, "free action"))
	if bool(player_standard_actions):
		combat_actions.push_front(Action.new(self, "standard action"))
	ActionSelection.list_actions(combat_actions)

func list_free_actions():
	var result = Character.get_free_actions()
	result.push_back(Action.new(self,"actions_back", "back"))
	ActionSelection.list_actions(result)

func list_standard_actions():
	var result = Character.get_standard_actions()
	result.push_back(Action.new(self, "flee"))
	result.push_back(Action.new(self,"actions_back", "back"))
	ActionSelection.list_actions(result)

func _on_character_performed_standard_action():
	player_standard_actions -= 1
	list_combat_actions()

func _on_character_performed_free_action():
	player_free_actions -= 1

func end_combat():
	print("-end combat-")
	initiative_mod = {}
	get_node("/root/Game/ModeMachine").mode_swap("DungeonMode")
