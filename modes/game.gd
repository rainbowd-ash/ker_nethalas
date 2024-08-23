extends Node
class_name Game

@export var initial_mode : Mode
@export var action_selection_ui : Node

func _ready():
	$ModeMachine.initialize(initial_mode)
