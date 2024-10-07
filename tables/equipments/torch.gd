extends Equipment
class_name Torch

var turns_remaining : int = 20

func _ready() -> void:
	SignalBus.new_room_rolls_finished.connect(_on_room_rolls_finished)
	SignalBus.room_reentered.connect(_on_room_rolls_finished)
	SignalBus.burn_light.connect(_on_force_burn)

func _init():
	title = "torch"
	weight = Item.weights.light
	cost = 10
	type = equipment_types.lightsource
	update_description()

func _on_room_rolls_finished() -> void:
	if equipped():
		burn_torch()

func _on_force_burn(amount : int):
	if equipped():
		for i in range(0, amount):
			burn_torch()

func equipped() -> bool:
	if get_parent() is GearSlot:
		return true
	return false

func light_remaining() -> int:
	return turns_remaining

# triggers every time player enters a room
func burn_torch() -> void:
	turns_remaining -= 1
	if turns_remaining == 0:
		SignalBus.chat_log.emit("Your torch burns out...")
		consume_item()
	else:
		update_description()

func update_description():
	description = "Serves as a light source. %d rooms remaining." % turns_remaining
