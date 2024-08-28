extends Node
class_name Mode

@export var attached_scene : PackedScene
@export var attached_node : Node

func enter() -> void:
	attached_node.show()

func exit() -> void:
	attached_node.hide()
