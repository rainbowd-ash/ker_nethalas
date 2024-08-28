extends Node
class_name ModeMachine

@export var initial_mode : Mode
@onready var current_mode : Mode
var modes : Dictionary = {}

func _ready():
	for child in get_children():
		if child is Mode:
			modes[child.name] = child

func initialize(starting_mode : Mode = initial_mode):
	current_mode = starting_mode
	current_mode.enter()
	SignalBus.mode_transition.emit(current_mode.name)

func mode_swap(new_mode_name : String):
	current_mode.exit()
	current_mode = modes[new_mode_name]
	current_mode.enter()
	SignalBus.mode_transition.emit(current_mode.name)

func get_current_mode() -> String:
	return current_mode.name
