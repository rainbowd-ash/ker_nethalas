extends Node
class_name Game

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("inventory_toggle"):
		toggle_inventory()
	elif event.is_action_pressed("debug_force_combat"):
		get_node("/root/Game").start_combat()

func _ready():
	call_deferred("setup") # called on the first frame of the game running (after all _ready()s)

func setup() -> void:
	$UiModes.initialize()
	$GameModes.initialize()

func start_combat(values : CombatSetupValues = CombatSetupValues.new(BlightfangRats.new())):
	$GameModes.mode_swap("CombatMode")
	$Combat.initialize(values)

func toggle_inventory():
	if $UiModes.get_current_mode() != "InventoryMode":
		$UiModes.mode_swap("InventoryMode")
	else:
		$UiModes.mode_swap("ExploreMode")

func _on_inventory_button_pressed() -> void:
	toggle_inventory()
