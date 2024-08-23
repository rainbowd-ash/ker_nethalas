extends Item
class_name CookingSupplies

func _init(a_quantity : int = 1) -> void:
	title = "cooking supplies"
	weight = weights.light
	cost = 0
	description = "used to create rations, or eaten raw"
	quantity = a_quantity
