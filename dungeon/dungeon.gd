extends Node2D
class_name Dungeon

@export var pawn : Node
signal moved_through_door


func _unhandled_input(event):
	if event.is_action_pressed("ui_down"):
		%RoomSelector.update_selector()
	if event.is_action_pressed("ui_up"):
		print(get_doors())

func current_room():
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

func roll_tension():
	pass

func roll_combat():
	pass

func roll_event():
	pass


