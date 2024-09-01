extends Node
class_name Gear

func get_equipped() -> Array:
	return get_children()

func can_equip(equipment : Equipment) -> bool:
	for equipped in get_children():
		if equipped.type == equipment.type:
			return false
	return true

func equip(equipment : Equipment) -> void:
	add_child(equipment)

func unequip(equipment : Equipment) -> Equipment:
	var unequipped = equipment
	remove_child(equipment)
	return unequipped

# stat modification methods
# ===================================================================
func modify_max_carry_capacity() -> int:
	var cap_mod : int = 0
	for armor in get_equipped():
		if armor.has_method("modify_max_carry_capacity"):
			cap_mod += armor.modify_max_inventory_size()
	return cap_mod + %Inventory.base_capacity
