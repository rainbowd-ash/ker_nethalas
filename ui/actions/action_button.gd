extends Button
class_name ActionButton

var action : Action

func _ready() -> void:
	pressed.connect(send_action)

func _init(a_action : Action) -> void:
	action = a_action

func send_action():
	action.source_node.do_action(action.key)
