extends Node2D
class_name Dungeon

@export var pawn : Node

var tension_die : UsageDie = UsageDie.new("d8")

func _ready() -> void:
	current_room().visited = true
	update_map()
	door_labels()

func list_actions():
	var actions = current_room().get_actions()
	var take_break = Action.new(self, "take a break")
	actions.append(take_break)
	Router.actions_ui.list_actions(actions)

func do_action(action_key : String):
	if action_key == "take a break":
		take_break()

func current_room() -> Room:
	return pawn.get_parent()

func get_room_items() -> Array:
	return current_room().get_items()

func pick_up_item(item : Item):
	return current_room().remove_item(item)

func drop_item(item : Item):
	current_room().add_item(item)

func move_through_door(door : Door):
	door_labels(true)
	pawn.reparent(door.get_parent(), false)
	var new_room = not current_room().visited
	current_room().visited = true
	update_map()
	SignalBus.moved_through_door.emit()
	if new_room:
		roll_room_checks()
	else:
		Character.light_check()
		SignalBus.room_reentered.emit()
	door_labels()
	if Router.game_modes.get_current_mode() == "DungeonMode":
		list_actions()

func door_labels(clear : bool = false):
	var doors = current_room().get_doors()
	var counter = 1
	if clear:
		for door in doors:
			door.set_label("")
		return
	for door in doors:
		door.set_label(str(counter))
		counter += 1

func update_map() -> void:
	for child in get_children():
		if child is Room:
			if child.visited:
				child.show()
			else:
				child.hide()

# roll tension,
# roll combat, 
	# if no combat, roll events
func roll_room_checks():
	if tension_die.roll():
		print("growing darkness table roll")
	var combat_roll = Dice.roll("1d20")
	if combat_roll > 10:
		roll_combat_encounter()
		if Router.game_modes.get_current_mode() == "CombatMode":
			await SignalBus.combat_finished
	else:
		pass # TODO events table check
	Character.light_check()
	SignalBus.new_room_rolls_finished.emit()

func roll_combat_encounter():
	# roll to see if combat happens
	# if so, roll a monster
	get_node("/root/Game").start_combat()

func take_break():
	SignalBus.chat_log.emit("You take a break and recover health, toughness, and exhaustion.")
	Character.recover_toughness(Dice.roll("1d10"))
	Character.recover_health(1)
	Character.recover_exhaustion(2)
	SignalBus.burn_light.emit(5) # TODO: how to handle taking a break with <5 light remaining?
	tension_die.shrink() # TODO: how to handle tension die shrinking when already at min size?
