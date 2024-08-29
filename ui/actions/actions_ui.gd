extends Control
class_name ActionsUi

func list_actions(actions : Array):
	clear_action_buttons()
	for action in actions:
		if action is not Action:
			push_warning("list actions was sent something weird")
		else:
			var button = ActionButton.new(action)
			button.text = action.title
			$Buttons.add_child(button)

func clear_action_buttons():
	for child in $Buttons.get_children():
		child.queue_free()
