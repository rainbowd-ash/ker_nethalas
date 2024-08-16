extends Control
class_name InventoryUI

@onready var inventory = get_node("/root/Character/Inventory")

func _ready():
	refresh_items()

func refresh_items():
	for child in %ItemList.get_children():
		child.queue_free()
	for item in inventory.get_items():
		var label = Label.new()
		label.text = item.title
		%ItemList.add_child(label)
