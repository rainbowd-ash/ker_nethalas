extends VBoxContainer

func update_details(item : Item) -> void:
	$Title.text = "%s" % [item.title]
	$Weight.text = "weight: %s" % [Item.weights.keys()[item.weight]]
	$Cost.text = "cost: %dc" % [item.cost]
	$Description.text = "%s" % [item.description]

func _ready() -> void:
	for child in get_children():
		if child is Label:
			child.text = ""
