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

func list_item_actions(item : Item):
	Router.actions_ui.list_actions([
		Action.new(self, "equip","equip",(true if item is Equipment else false)),
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
		var line_item = ItemButton.new(item)
		line_item.item_button_pressed.connect(set_details_and_buttons)
		line_item.set_button_group(inventory_item_button_group)
		%ItemList.add_child(line_item)
	if %ItemList.get_child_count():
		%ItemList.get_children()[0].grab_focus()
		set_details_and_buttons(%ItemList.get_children()[0].item)
	if not %ItemList.get_child_count():
		var nothing_label = Label.new()
		nothing_label.set_text("inventory empty")
		%ItemList.add_child(nothing_label)

func set_details_and_buttons(item : Item):
	%ItemDetails.update_details(item)
	list_item_actions(item)

func _on_item_picked_up(_item_name):
	refresh_items()

func _on_mode_transition(new_mode_name):
	if new_mode_name == "InventoryMode":
		refresh_items()
