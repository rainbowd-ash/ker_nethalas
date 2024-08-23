extends Control
class_name ActionSelection

var actions = []
var current_mode : String

func _ready() -> void:
	SignalBus.mode_transition.connect(_on_mode_change)

func _on_mode_change(new_mode_name : String):
	current_mode = new_mode_name

func list_actions(actions : Array):
	$ActionList.text = ""
	var counter : int = 1
	for action in actions:
		$ActionList.append_text("%d %s\n" % [counter, action])
		counter += 1
