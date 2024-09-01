extends VBoxContainer

func update_details(item : Item) -> void:
	clear()
	$Title.text = "%s" % [item.title]
	$Weight.text = "weight: %s" % [Item.weights.keys()[item.weight]]
	$Cost.text = "cost: %dc" % [item.cost]
	$Description.text = "%s" % [item.description]
	if item is Equipment:
		$GearSlot.text = "%s" % [Equipment.equipment_types.keys()[item.equipment_type]]

func _ready() -> void:
	clear()

func clear() -> void:
	for child in get_children():
		if child is Label:
			child.text = ""
