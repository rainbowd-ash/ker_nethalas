extends Item
class_name CraftingSupplies

func _init(a_quantity : int = 1) -> void:
	title = "crafting supplies"
	weight = weights.light
	cost = 0
	description = "used to craft items at camp"
	quantity = a_quantity
