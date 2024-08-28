extends Node
class_name Game

@export var action_selection_ui : Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory_toggle"):
		if $UiModes.get_current_mode() != "InventoryMode":
			$UiModes.mode_swap("InventoryMode")
		else:
			$UiModes.mode_swap("ActionSelectionMode")

func _ready():
	$UiModes.initialize()
	$GameModes.initialize()

func start_combat(values : CombatSetupValues):
	$GameModes.mode_swap("CombatMode")
	$Combat.initialize(values)
