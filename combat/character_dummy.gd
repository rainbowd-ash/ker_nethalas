extends Node
class_name CharacterDummy
# dummy stand-in for character during combat

var base_standard_action_count : int = 1
var base_free_action_count : int = 1

var standard_action_count : int = 1
var free_action_count : int = 1

var initiative : bool = true
var initiative_mod : int = 0

var surprised : bool = false
var attempting_stealth : bool = false

func reset_action_counts():
	standard_action_count = base_standard_action_count
	free_action_count = base_free_action_count

func do_action(action_key : String):
	if action_key == "standard attack":
		standard_attack()
	elif action_key == "flee":
		flee()

func list_player_actions():
	Router.actions_ui.list_actions([
		Action.new(self,"standard attack"),
		Action.new(self,"flee")
	])

func standard_attack():
	print("standard attack")
	get_parent().player_round_finished.emit()

func flee():
	print("flee")
	get_parent().in_combat = false
	get_parent().player_round_finished.emit()
