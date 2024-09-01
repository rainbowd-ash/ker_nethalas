extends Control
class_name InventoryUI

# Adding sections to this is such a giant pain, there has got to be a better way. Probably a class.

# TODO keeping the buttons and description for selected item after refreshing view
	# else, pick the top of the same section
	# else pick the top item

@onready var inventory = Character.inventory
@onready var gear = Character.gear

var inventory_item_button_group = ButtonGroup.new()

func _ready():
	hide()
	SignalBus.item_picked_up.connect(_on_item_picked_up)
	SignalBus.mode_transition.connect(_on_mode_transition)

func setup():
	refresh_inventory()

func list_actions():
	Router.actions_ui.list_actions([
		Action.new(self, "back"),
	])

func list_floor_item_actions(item : Item):
	Router.actions_ui.list_actions([
		Action.new(self, "pick up"),
		Action.new(self, "back"),
	])

func list_item_actions(item : Item):
	Router.actions_ui.list_actions([
		Action.new(self, "equip","equip",(true if item is Equipment else false)),
		Action.new(self, "drop","drop",(true if %ItemList.get_children() else false)),
		Action.new(self, "back"),
		])

func list_gear_actions(_equipment : Equipment):
	Router.actions_ui.list_actions([
		Action.new(self, "unequip"),
		Action.new(self, "back"),
		])

func do_action(action_key : String):
	if action_key == "equip":
		inventory.equip(get_item_from_selected_button())
		refresh_inventory()
	elif action_key == "unequip":
		inventory.add_item(gear.unequip(get_item_from_selected_button()))
		refresh_inventory()
	elif action_key == "drop":
		inventory.drop_item(get_item_from_selected_button())
		refresh_inventory()
	elif action_key == "pick up":
		inventory.add_item(Router.dungeon.pick_up_item(get_item_from_selected_button()))
		refresh_inventory()
	elif action_key == "back":
		Router.ui_modes.mode_swap("ExploreMode")

func get_item_from_selected_button() -> Item:
	for button in %FloorItemList.get_children():
		if button.button_pressed == true:
			return button.item
	for button in %GearList.get_children():
		if button.button_pressed == true:
			return button.item
	for button in %ItemList.get_children():
		if button.button_pressed == true:
			return button.item
	return null

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
	for child in %FloorItemList.get_children():
		child.free()
	refresh_gear()
	refresh_items()
	refresh_floor_items()
	list_actions()

func refresh_floor_items():
	for item in Router.dungeon.get_room_items():
		%FloorItemList.add_child(create_line_item(item))

func refresh_gear():
	for equipment in gear.get_equipped():
		var line_item = create_line_item(equipment)
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
	elif button.get_parent() == %FloorItemList:
		list_floor_item_actions(button.item)

func _on_item_picked_up(_item_name):
	refresh_inventory()

func _on_mode_transition(new_mode_name):
	if new_mode_name == "InventoryMode":
		refresh_inventory()
