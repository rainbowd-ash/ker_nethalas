extends Node
class_name Game

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory_toggle"):
		if $UiModes.get_current_mode() != "InventoryMode":
			$UiModes.mode_swap("InventoryMode")
		else:
			$UiModes.mode_swap("ExploreMode")

func _ready():
	call_deferred("setup") # called on the first frame of the game running (after all _ready()s)

func setup() -> void:
	$UiModes.initialize()
	$GameModes.initialize()

func start_combat(values : CombatSetupValues):
	$GameModes.mode_swap("CombatMode")
	$Combat.initialize(values)
