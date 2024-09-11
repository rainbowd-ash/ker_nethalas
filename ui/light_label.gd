extends Label

func _ready() -> void:
	SignalBus.room_reentered.connect(update_label)
	SignalBus.new_room_rolls_finished.connect(update_label)
	SignalBus.item_equipped.connect(update_equip)
	SignalBus.item_dequipped.connect(update_equip)

func update_equip(equipment):
	update_label()

func update_label():
	text = "light: %d" % Character.gear.equipped_light.light_remaining()
