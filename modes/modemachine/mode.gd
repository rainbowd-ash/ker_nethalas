# https://www.sandromaglione.com/articles/how-to-implement-state-machine-pattern-in-godot
extends Node
class_name Mode

signal transitioned(new_mode_name : String) # O_O

@export var attached_scene : Node

func enter() -> void:
	attached_scene.show()
	transitioned.emit(name)

func exit() -> void:
	attached_scene.hide()
