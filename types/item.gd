extends Node
class_name Item

enum weights {
	light, # can stack to 10
	normal, # single slot
	heavy # takes 2 slots
}

var title : String = "default_title"
var weight : int = weights.normal
var cost : int = 0
var description : String = "default_description"
# quantity of item for light items
	# keep at 0 for normal/heavy
var quantity : int = 0
var stack_size : int = 10

var item_actions = [
	"drop"
]

func consume_item():
	queue_free()

func get_item_details():
	return {
		"title": title,
		"weight": weights.keys()[weight],
		"cost": cost,
		"description": description,
	}

func get_actions():
	return item_actions

func do_action(action : String):
	if action == "drop":
		$Character/Inventory.remove_item(self)
