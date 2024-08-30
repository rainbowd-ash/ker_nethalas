extends Node2D
class_name Dungeon

@export var pawn : Node

func _ready() -> void:
	current_room().visited = true
	update_map()
	door_labels()

func list_actions():
	var actions = current_room().get_actions()
	Router.actions_ui.list_actions(actions)

func current_room() -> Room:
	return pawn.get_parent()

func move_through_door(door : Door):
	door_labels(true)
	pawn.reparent(door.get_parent(), false)
	current_room().visited = true
	update_map()
	SignalBus.moved_through_door.emit()
	list_actions()
	door_labels()
	roll_combat_encounter()

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

func roll_combat_encounter():
	# roll to see if combat happens
	# if so, roll a monster
	get_node("/root/Game").start_combat(CombatSetupValues.new(BlightfangRats.new()))
