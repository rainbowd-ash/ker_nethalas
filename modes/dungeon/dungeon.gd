extends Node2D
class_name Dungeon

@export var pawn : Node
signal moved_through_door

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		%RoomSelector.update_selector()
	if event.is_action_pressed("pickup"):
		if not current_room().get_items().is_empty():
			pick_up_item(current_room().get_items()[0])

func _ready() -> void:
	list_actions()

func list_actions():
	var actions = current_room().get_actions()
	ActionSelection.list_actions(actions)

func pick_up_item(item : Item):
	var room = current_room()
	if room.get_items().has(item):
		SignalBus.item_picked_up.emit(item)
		room.remove_item(item)
		print("Picked up " + item.title)

func current_room() -> Room:
	return pawn.get_parent()

func move_through_door(door : Door):
	door_labels(true)
	pawn.reparent(door.get_parent(), false)
	SignalBus.moved_through_door.emit()
	list_actions()
	door_labels()
	roll_combat_encounter()

func get_doors():
	return current_room().get_doors()

func door_labels(clear : bool = false):
	var doors = get_doors()
	var counter = 1
	if clear:
		for door in doors:
			door.set_label("")
		return
	for door in doors:
		door.set_label(str(counter))
		counter += 1

func roll_combat_encounter():
	# roll to see if combat happens
	# if so, roll a monster
	get_node("/root/Game").start_combat(CombatSetupValues.new(BlightfangRats.new()))
