extends Control
class_name InventoryUI

@onready var inventory = get_node("/root/Character/Inventory")

func _unhandled_input(event):
	if event.is_action_pressed("inventory_toggle"):
		if visible:
			hide()
		else:
			show()

func _ready():
	refresh_items()
	SignalBus.item_picked_up.connect(_on_item_picked_up)

func refresh_items():
	for child in %ItemList.get_children():
		child.queue_free()
	for item in inventory.get_items():
		var label = Label.new()
		label.text = item.title
		%ItemList.add_child(label)

func _on_item_picked_up(item : Item):
	refresh_items()
