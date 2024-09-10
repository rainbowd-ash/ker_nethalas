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
	Router.actions_ui.list_actions(actions)

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
	else:
		print("events table roll")

func roll_combat_encounter():
	# roll to see if combat happens
	# if so, roll a monster
	get_node("/root/Game").start_combat()
