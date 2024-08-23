extends Node2D
class_name Dungeon

@export var pawn : Node
signal moved_through_door

func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		print(get_doors())
	if event.is_action_pressed("ui_accept"):
		%RoomSelector.update_selector()
	if event.is_action_pressed("pickup"):
		if not current_room().get_items().is_empty():
			pick_up_item(current_room().get_items()[0])

func _ready() -> void:
	list_actions()

func list_actions():
	var actions = current_room().get_actions()
	get_node("/root/Game/ActionSelection").list_actions(actions)

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
	moved_through_door.emit()
	door_labels()

func get_doors():
	return current_room().get_doors()

func door_labels(clear : bool = false):
	var doors = get_doors()
	if clear:
		for i in range(0,len(doors)):
			doors[i].set_label("")
		return
	for i in range(0,len(doors)):
		doors[i].set_label(str(i))
