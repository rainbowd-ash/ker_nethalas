extends Node
class_name Gear

func equip(equipment : Equipment) -> void:
	add_child(equipment)

func unequip(equipment : Equipment) -> Equipment:
	var unequipped = equipment
	remove_child(equipment)
	return unequipped

func drop(equipment : Equipment) -> void:
	Router.dungeon.current_room().add_child(unequip(equipment))

func get_equipped() -> Array:
	return get_children()

func can_equip(equipment : Equipment) -> bool:
	for equipped in get_children():
		if equipped.type == equipment.type:
			return false
	return true

func get_weapon() -> Weapon:
	for equipment in get_equipped():
		if equipment is Weapon:
			return equipment
	return null

func has_shield() -> bool:
	for equipment in get_equipped():
		if equipment is Shield:
			return true
	return false

# stat modification methods
# ===================================================================
func modify_max_carry_capacity() -> int:
	var cap_mod : int = 0
	for armor in get_equipped():
		if armor.has_method("modify_max_carry_capacity"):
			cap_mod += armor.modify_max_inventory_size()
	return cap_mod + %Inventory.base_capacity

func modify_attack_skill() -> int:
	var atk_mod : int = 0
	for equipment in get_equipped():
		if equipment.has_method("modify_attack_skill"):
			atk_mod += equipment.modify_attack_skill()
	return atk_mod

func modify_defense_skill() -> int:
	var mod : int = 0
	for equipment in get_equipped():
		if equipment.has_method("modify_defense_skill"):
			mod += equipment.modify_defense_skill()
	return mod

func modify_initiative_value() -> int:
	var mod : int = 0
	for equipment in get_equipped():
		if equipment.has_method("modify_initiative_value"):
			mod += equipment.modify_initiative_value()
	return mod

func modify_damage_roll() -> int:
	var mod : int = 0
	for equipment in get_equipped():
		if equipment.has_method("modify_damage_roll"):
			mod += equipment.modify_damage_roll()
	return mod
