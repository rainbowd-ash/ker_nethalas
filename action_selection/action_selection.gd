extends Control
#class_name ActionSelection

var ui_node : Control

var actions : Array = []
var current_mode : String

func _unhandled_input(event: InputEvent) -> void:
	# better way to do this??
	if not actions.is_empty():
		if event.is_action_pressed("action_1"):
			send_action(1)
			return
		if event.is_action_pressed("action_2"):
			send_action(2)
			return
		if event.is_action_pressed("action_3"):
			send_action(3)
			return
		if event.is_action_pressed("action_4"):
			send_action(4)
			return
		if event.is_action_pressed("action_5"):
			send_action(5)
			return
		if event.is_action_pressed("action_6"):
			send_action(6)
			return
		if event.is_action_pressed("action_7"):
			send_action(7)
			return
		if event.is_action_pressed("action_8"):
			send_action(8)
			return
		if event.is_action_pressed("action_9"):
			send_action(9)
			return

func send_action(id : int):
	if actions.size() >= id and id > 0:
		id -= 1
		actions[id].source_node.do_action(actions[id].key)

func _ready() -> void:
	ui_node = get_node("/root/Game").action_selection_ui
	SignalBus.mode_transition.connect(_on_mode_change)

func _on_mode_change(new_mode_name : String):
	current_mode = new_mode_name

func list_actions(new_actions : Array):
	actions = new_actions
	ui_node.get_node("ActionList").text = ""
	var counter : int = 1
	for action in actions:
		ui_node.get_node("ActionList").append_text("%d %s\n" % [counter, action.title])
		counter += 1
