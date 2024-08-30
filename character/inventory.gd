extends Node
class_name Inventory


# list of item objects
var items = []
var base_capacity = 10
var currency = 0 # TODO coins and gems take up 1 slot per 100

func _ready():
	SignalBus.item_picked_up.connect(_on_item_picked_up)

func get_items():
	return items

func add_item(item : Item): # TODO attempt to stack light items first
	items.push_back(item)

func drop_item_at(index : int):
	items.remove_at(index)

func adjust_currency(amount : int):
	currency += amount
	SignalBus.chat_log.emit("picked up %d coins" % amount)

func _on_item_picked_up(item : Item):
	add_item(item)
