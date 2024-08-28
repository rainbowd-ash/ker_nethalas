extends Node
class_name Game

@export var initial_mode : Mode
@export var action_selection_ui : Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory_toggle"):
		$Ui/InventoryUi.toggle()

func _ready():
	$GameModes.initialize(initial_mode)

func start_combat(values : CombatSetupValues):
	$GameModes.mode_swap("CombatMode")
	$Combat.initialize(values)
