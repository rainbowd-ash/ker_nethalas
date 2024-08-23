# https://www.sandromaglione.com/articles/how-to-implement-state-machine-pattern-in-godot
extends Node
class_name ModeMachine

@onready var current_mode : Mode
var modes : Dictionary = {}

func _ready():
	for child in get_children():
		if child is Mode:
			modes[child.name] = child
			child.transitioned.connect(_on_child_transitioned)
		else:
			push_warning("State machine contains child which is not 'State'")

func initialize(starting_mode):
	current_mode = starting_mode
	current_mode.enter()
	SignalBus.mode_transition.emit(current_mode.name)

func _on_child_transitioned(new_mode_name : StringName) -> void:
	var new_mode = modes.get(new_mode_name)
	if new_mode != null:
		if new_mode.name != current_mode.name:
			current_mode.exit()
			new_mode.enter()
			current_mode = new_mode
			SignalBus.mode_transition.emit(current_mode.name)
	else:
		push_warning("Called transition on a state that does not exist")
