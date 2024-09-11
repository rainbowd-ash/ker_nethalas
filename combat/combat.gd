extends Node
class_name Combat

signal player_round_finished
signal stealth_action_choice
signal stealth_finished

var in_combat : bool = true
var round_counter : int = 0

var finished_stealth : bool = false
var stealth_check_result : OpposedCheckResult = null

func do_action(action_key : String):
	if action_key == "attempt stealth":
		SignalBus.chat_log.emit("you attempt to sneak up on the monster")
		$CharacterDummy.attempting_stealth = true
		stealth_action_choice.emit()
	elif action_key == "no stealth":
		SignalBus.chat_log.emit("you do not sneak up on the monster")
		stealth_action_choice.emit()
	elif action_key == "pass":
		SignalBus.chat_log.emit("player passes turn")
		player_round_finished.emit()
	elif action_key == "flee":
		in_combat = false
		player_round_finished.emit()
	elif action_key == "back":
		list_actions()

func initialize(values : CombatSetupValues):
	SignalBus.chat_log.emit("-combat starting-\n")
	print("-combat starting-")
	$CharacterDummy.surprised = values.player_surprised
	add_monster(values.monster)
	await stealth_check()
	initiative_check()
	print("-regular combat starting-")
	combat_rounds()

func list_actions():
	if not finished_stealth:
		list_stealth_actions()
	else:
		$CharacterDummy.list_player_actions()

func add_monster(monster : Monster):
	add_child(monster)
	for i in range(1, monster.number):
		add_child(monster.duplicate())

func get_monsters() -> Array:
	var return_array = []
	for child in get_children():
		if child is Monster and child.active:
			return_array.push_back(child)
	return return_array

func monster_picker():
	var action_list = []
	for monster in get_monsters():
		action_list.push_back(Action.new(monster, "monster_pick", "%s" % monster.title))
	action_list.push_back(Action.new(self, "back"))
	Router.actions_ui.list_actions(action_list)

func monster_part_picker(monster : Monster):
	var action_list = []
	var parts : Dictionary = monster.body_plan.parts
	for part in parts:
		var button_title = "%s" % parts[part].title
		if parts[part].weak_spot:
			button_title = "♥ " + button_title
		action_list.push_back(Action.new(
			monster, 
			"part_pick-%s" % part , 
			button_title, 
			not parts[part].disabled))
	action_list.push_back(Action.new(self, "back"))
	Router.actions_ui.list_actions(action_list)

func stealth_check():
	if $CharacterDummy.surprised:
		print("character surprised, skipping stealth check")
		return
	list_stealth_actions()
	await stealth_action_choice
	finished_stealth = true
	if $CharacterDummy.attempting_stealth:
		var highest_awareness : int = 0
		for monster in get_monsters():
			if monster.awareness > highest_awareness:
				highest_awareness = monster.get_skill("awareness")
		stealth_check_result = Dice.opposed_check(
			CheckValue.new(Character.skills.get_skill("stealth")),
			CheckValue.new(highest_awareness)
		)
		if stealth_check_result.winner == Dice.opposed_winner.defender:
			$CharacterDummy.initiative_mod -= 10
	return

func list_stealth_actions():
	Router.actions_ui.list_actions([
		Action.new(self, "attempt stealth", "go for a sneak attack"),
		Action.new(self, "no stealth", "run in and attack"),
		])

func initiative_check():
	# TODO handle crit failure
	print("-initiative roll-")
	if stealth_check_result:
		if stealth_check_result.winner == Dice.opposed_winner.attacker:
			SignalBus.chat_log.emit("player gets initiative from stealth success")
			$CharacterDummy.initiative = true
			return
	var highest_awareness = 0
	for monster in get_monsters():
		if monster.awareness > highest_awareness:
			highest_awareness = monster.awareness
	var roll_result : OpposedCheckResult = Dice.opposed_check(
		CheckValue.new(Character.skills.get_skill("initiative")),
		CheckValue.new(highest_awareness),
	)
	if roll_result.winner == Dice.opposed_winner.attacker:
		SignalBus.chat_log.emit("player gets initiative")
		$CharacterDummy.initiative = true
	else: 
		SignalBus.chat_log.emit("monster gets initiative")
		$CharacterDummy.initiative = false

func combat_rounds():
	if not $CharacterDummy.initiative and in_combat and round_counter == 0:
		for monster in get_monsters():
			print("%s round 0 action" % monster.title)
			monster_action(monster)
	# combat loop
	while in_combat:
		if get_monsters().size() == 0:
			in_combat = false
		round_counter += 1
		print("combat round %d" % round_counter)
		SignalBus.chat_log.emit("\n-combat round %d-" % round_counter)
		if in_combat:
			print("player action")
			$CharacterDummy.list_player_actions()
			await player_round_finished
		if in_combat:
			for monster in get_monsters():
				print("%s action" % monster.title)
				monster_action(monster)
	# exit combat loop condition
	if not in_combat:
		end_combat()

func monster_action(monster : Monster):
	# TODO: this is wrong-- 
	# the monster picks a move from their movelist first, 
	# then if they picked an attack the opposed check is rolled.
	var roll = Dice.opposed_check(
		CheckValue.new(monster.get_skill("attack")),
		CheckValue.new(Character.skills.get_skill("defence"))
	)
	if roll.winner == Dice.opposed_winner.attacker:
		monster.roll_attack()
	else:
		# TODO defender gets roll on defensive move table
		SignalBus.chat_log.emit("%s attacks! you dodge the attack!" % monster.title)

func end_combat():
	SignalBus.chat_log.emit("-end combat-")
	SignalBus.combat_finished.emit()
	Router.game_modes.mode_swap("DungeonMode")

# used by Monster
func get_character_dummy() -> CharacterDummy:
	return $CharacterDummy
