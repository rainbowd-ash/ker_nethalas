extends Node
class_name Inventory

var base_capacity = 10
# TODO coins and gems take up 1 slot per 100
var currency = 0

func _ready():
	add_item(Torch.new())
	SignalBus.item_picked_up.connect(_on_item_picked_up)

# list of item objects
var items = []

func get_items():
	return items

func add_item(item : Item):
	# TODO attempt to stack light items first
	items.push_back(item)
	# emit signal?

func remove_item(r_item : Item):
	for item in items:
		if item.name == r_item:
			items.erase(r_item)
			return
	# emit signal

func adjust_currency(amount : int):
	currency += amount

func _on_item_picked_up(item : Item):
	add_item(item)
