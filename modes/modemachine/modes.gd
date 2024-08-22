# https://www.sandromaglione.com/articles/how-to-implement-state-machine-pattern-in-godot
extends Node
class_name ModeMachine

@onready var current_mode : Mode = $DungeonMode
var modes : Dictionary = {}

func _ready():
	for child in get_children():
		if child is Mode:
			modes[child.name] = child
			child.transitioned.connect(on_child_transitioned)
		else:
			push_warning("State machine contains child which is not 'State'")
			
	current_mode.Enter()

func on_child_transitioned(new_mode_name: StringName) -> void:
	var new_mode = modes.get(new_mode_name)
	if new_mode != null:
		if new_mode != current_mode:
			current_mode.Exit()
			new_mode.Enter()
			current_mode = new_mode
	else:
		push_warning("Called transition on a state that does not exist")
