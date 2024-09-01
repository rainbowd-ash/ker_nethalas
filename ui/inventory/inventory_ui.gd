extends Control
class_name InventoryUI

@onready var inventory = Character.inventory
@onready var gear = Character.gear

var inventory_item_button_group = ButtonGroup.new()

func _ready():
	hide()
	SignalBus.item_picked_up.connect(_on_item_picked_up)
	SignalBus.mode_transition.connect(_on_mode_transition)

func setup():
	refresh_inventory()

func list_item_actions(item : Item):
	Router.actions_ui.list_actions([
		Action.new(self, "equip","equip",(true if item is Equipment else false)),
		Action.new(self, "drop","drop",(true if %ItemList.get_children() else false)),
		Action.new(self, "back"),
		])

func list_gear_actions(equipment : Equipment):
	Router.actions_ui.list_actions([
		Action.new(self, "unequip"),
		Action.new(self, "back"),
		])

func do_action(action_key : String):
	if action_key == "equip":
		inventory.equip_item_at(get_selected_item_index())
		refresh_inventory()
	elif action_key == "unequip":
		gear.unequip_slot(get_selected_button().slot)
		refresh_inventory()
	elif action_key == "drop":
		inventory.drop_item_at(get_selected_item_index())
		refresh_inventory()
	elif action_key == "back":
		Router.ui_modes.mode_swap("ExploreMode")

func get_selected_button():
	for button in %GearList.get_children():
		if button.button_pressed == true:
			return button
	for button in %ItemList.get_children():
		if button.button_pressed == true:
			return button

func get_selected_item_index():
	var selected_item = inventory_item_button_group.get_pressed_button()
	for i in range(0, %ItemList.get_children().size()):
		if %ItemList.get_children()[i] == selected_item:
			return i
	return -1

func create_line_item(item : Item) -> ItemButton:
	var line_item = ItemButton.new(item)
	line_item.item_button_pressed.connect(set_details_and_buttons)
	line_item.set_button_group(inventory_item_button_group)
	return line_item

func refresh_inventory():
	%ItemDetails.clear()
	for child in %ItemList.get_children():
		child.free()
	for child in %GearList.get_children():
		child.free()
	refresh_gear()
	refresh_items()
	if %ItemList.get_children():
		%ItemList.get_children()[0].set_pressed(true)
		set_details_and_buttons(%ItemList.get_children()[0])
	if not %ItemList.get_child_count():
		var nothing_label = Label.new()
		nothing_label.set_text("inventory empty")
		%ItemList.add_child(nothing_label)

func refresh_gear():
	for equipment in Character.gear.equipped:
		if Character.gear.equipped[equipment]:
			var line_item = create_line_item(Character.gear.equipped[equipment])
			line_item.slot = equipment
			%GearList.add_child(line_item)

func refresh_items():
	for item in inventory.get_items():
		var line_item = create_line_item(item)
		%ItemList.add_child(line_item)

func set_details_and_buttons(button : Button):
	%ItemDetails.update_details(button.item)
	if button.get_parent() == %ItemList:
		list_item_actions(button.item)
	elif button.get_parent() == %GearList:
		list_gear_actions(button.item)

func _on_item_picked_up(_item_name):
	refresh_inventory()

func _on_mode_transition(new_mode_name):
	if new_mode_name == "InventoryMode":
		refresh_inventory()
