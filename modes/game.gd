extends Node
class_name Game

@export var initial_mode : Mode

func _ready():
	$ModeMachine.initialize(initial_mode)
