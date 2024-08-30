extends Control
class_name InventoryUI

@onready var inventory = Character.inventory

var inventory_item_button_group = ButtonGroup.new()

func _ready():
	hide()
	SignalBus.item_picked_up.connect(_on_item_picked_up)
	SignalBus.mode_transition.connect(_on_mode_transition)

func setup():
	refresh_items()
	list_item_actions()

func list_item_actions():
	Router.actions_ui.list_actions([
		Action.new(self, "drop"),
		Action.new(self, "back"),
		])

func do_action(action_key : String):
	if action_key == "drop":
		inventory.drop_item_at(get_selected_item_index())
		refresh_items()
	if action_key == "back":
		Router.ui_modes.mode_swap("ExploreMode")

func get_selected_item_index():
	var selected_item = inventory_item_button_group.get_pressed_button()
	for i in range(0, %ItemList.get_children().size()):
		if %ItemList.get_children()[i] == selected_item:
			return i
	return -1

func refresh_items():
	for child in %ItemList.get_children():
		child.free()
	for item in inventory.get_items():
		var line_item = Button.new()
		line_item.text = item.title
		line_item.focus_entered.connect(refresh_details)
		line_item.toggle_mode = true
		line_item.set_button_group(inventory_item_button_group)
		%ItemList.add_child(line_item)
	if %ItemList.get_child_count():
		%ItemList.get_children()[0].grab_focus()
		refresh_details()
	if not %ItemList.get_child_count():
		var nothing_label = Label.new()
		nothing_label.set_text("inventory empty")
		%ItemList.add_child(nothing_label)

func refresh_details():
	for child in %ItemDetails.get_children():
		child.free()
	var focus_index = get_selected_item_index()
	var properties = inventory.get_items()[focus_index].get_item_details()
	for property in properties:
		var label = Label.new()
		label.set_text("%s: %s" % [property, properties[property]])
		%ItemDetails.add_child(label)

func _on_item_picked_up(_item_name):
	refresh_items()

func _on_mode_transition(new_mode_name):
	if new_mode_name == "InventoryMode":
		refresh_items()
