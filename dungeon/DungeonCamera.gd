extends Camera2D
class_name DungeonCamera

@export var pawn : Node

func _on_dungeon_moved_through_door():
	set_global_position(pawn.get_global_position())
