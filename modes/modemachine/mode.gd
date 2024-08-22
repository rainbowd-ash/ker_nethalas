# https://www.sandromaglione.com/articles/how-to-implement-state-machine-pattern-in-godot
extends Node
class_name Mode

signal transitioned(new_mode_name : String) # O_O

var scene : String
var instantiated_scene : Node

func Enter() -> void:
	instantiated_scene = load(scene).instantiate()
	get_node("/root/Game").add_child.call_deferred(instantiated_scene)

func Exit() -> void:
	instantiated_scene.queue_free()
