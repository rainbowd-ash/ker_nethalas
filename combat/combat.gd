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
var round_counter : int = 0

func _ready() -> void:
	Character.performed_standard_action.connect(_on_character_performed_standard_action)
	Character.performed_free_action.connect(_on_character_performed_free_action)

func do_action(action_key : String):
	if action_key == "attempt stealth":
		SignalBus.chat_log.emit("-sneak attack attempt-")
		attempt_stealth()
		stealth_attempt_finished.emit()
	elif action_key == "no stealth":
		SignalBus.chat_log.emit("passed on sneak attack")
		stealth_attempt_finished.emit()
	elif action_key == "free action":
		list_free_actions()
	elif action_key == "standard action":
		list_standard_actions()
	elif action_key == "pass":
		SignalBus.chat_log.emit("player passes turn")
		player_round_finished.emit()
	elif action_key == "actions_back":
		list_combat_actions()
	elif action_key == "flee":
		in_combat = false
		player_round_finished.emit()

func initialize(values : CombatSetupValues):
	SignalBus.chat_log.emit("-combat starting-\n")
	add_monster(values.monster)
	if not values.player_surprised:
		list_stealth_actions()
		await stealth_attempt_finished
	roll_initiative()
	SignalBus.chat_log.emit("-regular combat starting-")
	combat_rounds()

func combat_rounds():
	# give monster first attack to make the loop simpler
	if not player_initiative and in_combat:
		monster_action()
		player_initiative = true
	
	# combat loop
	while in_combat:
		round_counter += 1
		SignalBus.chat_log.emit("-combat round %d-" % round_counter)
		if in_combat:
			player_action()
			await player_round_finished
		if in_combat:
			monster_action()
		# refresh actions
		player_standard_actions = 1
		player_free_actions = 1
	# exit combat loop condition
	if not in_combat:
		end_combat()


func add_monster(monster : Monster):
	add_child(monster)
	for i in range(1, monster.number):
		add_child(monster.duplicate())

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
			SignalBus.chat_log.emit("player gets initiative from stealth success")
			player_initiative = true
			return
	var character_initiative : int = Character.get_initiative_value()
	var highest_awareness = 0
	for monster in monsters:
		if monster.awareness > highest_awareness:
			highest_awareness = monster.awareness
	var roll_result : OpposedCheckResult = Dice.opposed_check(
		CheckValue.new(character_initiative),
		CheckValue.new(highest_awareness),
	)
	if roll_result.winner == Dice.opposed_winner.attacker:
		SignalBus.chat_log.emit("player gets initiative")
		player_initiative = true
	else: 
		SignalBus.chat_log.emit("monster gets initiative")
		player_initiative = false

func monster_action():
	print("monster swings!")
	for monster in get_children():
		var monster_attack_value = monster.get_attack_value()
		if not player_initiative:
			monster_attack_value += 10
		var roll_outcome = Dice.opposed_check(
			CheckValue.new(monster_attack_value),
			CheckValue.new(Character.get_defence_roll_value())
		)
		if roll_outcome.winner == Dice.opposed_winner.attacker:
			print("monster hits!")
			monster.do_action()
		else:
			# TODO defender gets roll on defensive move table
			print("player defends!")

func player_action():
	list_combat_actions()
	print("player action!")

func list_stealth_actions():
	Router.actions_ui.list_actions([
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
	Router.actions_ui.list_actions(combat_actions)

func list_free_actions():
	var result = Character.get_free_actions()
	result.push_back(Action.new(self,"actions_back", "back"))
	Router.actions_ui.list_actions(result)

func list_standard_actions():
	var result = Character.get_standard_actions()
	result.push_back(Action.new(self, "flee"))
	result.push_back(Action.new(self,"actions_back", "back"))
	Router.actions_ui.list_actions(result)

func _on_character_performed_standard_action():
	player_standard_actions -= 1
	list_combat_actions()

func _on_character_performed_free_action():
	player_free_actions -= 1
	list_combat_actions()

func end_combat():
	SignalBus.chat_log.emit("-end combat-")
	Router.game_modes.mode_swap("DungeonMode")
