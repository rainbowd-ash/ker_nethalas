extends Node2D
class_name Dungeon

func enter_room(room : Node):
	room.add_child(%Pawn)


func roll_tension():
	pass

func roll_combat():
	pass

func roll_event():
	pass
