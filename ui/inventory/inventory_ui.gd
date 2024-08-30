extends Control
class_name InventoryUI

@onready var inventory = Character.inventory

func _ready():
	hide()
	SignalBus.item_picked_up.connect(_on_item_picked_up)
	SignalBus.mode_transition.connect(_on_mode_transition)

func toggle():
	if not is_visible():
		show()
		refresh_items()
	elif is_visible():
		hide()

func refresh_items():
	for child in %ItemList.get_children():
		child.free()
	for item in inventory.get_items():
		var line_item = Button.new()
		line_item.text = item.title
		line_item.focus_entered.connect(refresh_details)
		%ItemList.add_child(line_item)
	%ItemList.get_children()[0].grab_focus()

func refresh_details():
	for child in %ItemDetails.get_children():
		child.free()
	var focus_index
	for i in range(0, %ItemList.get_children().size()):
		if %ItemList.get_children()[i].has_focus():
			focus_index = i
	var properties = inventory.get_items()[focus_index].get_item_details()
	for property in properties:
		var label = Label.new()
		label.set_text("%s: %s" % [property, properties[property]])
		%ItemDetails.add_child(label)

func _on_item_picked_up(_item_name):
	refresh_items()

func _on_mode_transition(_new_mode_name):
	refresh_items()
