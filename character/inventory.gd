extends Node
class_name Inventory

var base_capacity = 10

func _ready():
	add_item(Torch.new())
	SignalBus.item_picked_up.connect(_on_item_picked_up)

# list of item objects
var items = []

func get_items():
	return items

func add_item(item : Item):
	items.push_back(item)
	# emit signal?

func remove_item(r_item : Item):
	for item in items:
		if item.name == r_item:
			items.erase(r_item)
			return
	# emit signal

func _on_item_picked_up(item : Item):
	add_item(item)
