extends Node
class_name Inventory

# list of item objects
var base_capacity = 10
var currency = 0 # TODO coins and gems take up 1 slot per 100

func _ready():
	SignalBus.item_picked_up.connect(_on_item_picked_up)

func get_items():
	return get_children()

func add_item(item : Item): # TODO attempt to stack light items first
	add_child(item)

func equip_item(equipment : Equipment):
	if Character.gear.can_equip(equipment):
		remove_child(equipment)
		Character.gear.equip(equipment)

func drop_item(item : Item):
	remove_child(item)
	Router.dungeon.current_room().add_child(item)

func adjust_currency(amount : int):
	currency += amount
	SignalBus.chat_log.emit("picked up %d coins" % amount)

func _on_item_picked_up(item : Item):
	add_item(item)
