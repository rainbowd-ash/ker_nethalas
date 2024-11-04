extends ModeMachine
class_name GameModes

func do_action(action_key : String):
	if action_key == "mode_camping":
		mode_swap("CampMode")
