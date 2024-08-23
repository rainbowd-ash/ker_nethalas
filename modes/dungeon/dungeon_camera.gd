extends Camera2D
class_name DungeonCamera

@export var pawn : Node

func _ready():
	SignalBus.moved_through_door.connect(_on_moved_through_door)

func _on_moved_through_door():
	set_global_position(pawn.get_global_position())
