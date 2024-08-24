extends Equipment
class_name Backpack

var capacity_increase = 10

func _init():
	title = "backpack"
	weight = weights.normal
	cost = 500
	description = "Increases carrying capacity by %d item slots." % capacity_increase
	equipment_type = equipment_types.backpack

func modify_max_inventory_size():
	return capacity_increase
