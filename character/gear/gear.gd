extends Node
class_name Gear

func get_slots() -> Array:
	var result : Array = []
	for child in get_children():
		if child is GearSlot:
			result.push_back(child)
	return result

func equip(equipment : Equipment) -> void:
	var slot = can_equip(equipment)
	if slot:
		slot.equip(equipment)

func dequip(equipment : Equipment) -> Equipment:
	return equipment.get_parent().dequip(equipment)

func drop(equipment : Equipment) -> Equipment:
	var dropped = dequip(equipment)
	Router.dungeon.drop_item(dropped)
	return dropped

func get_equipped() -> Array:
	var equipped = []
	for child in get_slots():
		equipped += child.get_equipped()
	return equipped

func can_equip(equipment : Equipment) -> GearSlot:
	for slot in get_slots():
		if slot.can_equip(equipment):
			return slot
	return null

func get_weapons() -> Array:
	var weapons : Array = []
	for weapon in $WeaponSlot.get_equipped():
		weapons.push_back(weapon)
	if not weapons:
		weapons.push_back(unarmed_weapon())
	return weapons

func unarmed_weapon() -> Weapon:
	var fists = Weapon.new(Damage.damage_types.bludgeoning, "fist_weapons")
	fists.title = "unarmed strike"
	fists.die = "1d4"
	return fists

# skill modification methods
# ===================================================================
func modify_max_carry_capacity() -> int:
	var cap_mod : int = 0
	for armor in get_equipped():
		if armor.has_method("modify_max_carry_capacity"):
			cap_mod += armor.modify_max_inventory_size()
	return cap_mod + %Inventory.base_capacity

func modify_skill(skill : String) -> int:
	var skill_mod : int = 0
	for equipment in get_equipped():
		if equipment.has_method("modify_skill"):
			skill_mod = equipment.modify_skill(skill)
	return skill_mod

func modify_damage_roll() -> int:
	var dam_mod : int = 0
	for equipment in get_equipped():
		if equipment.has_method("modify_damage_roll"):
			dam_mod += equipment.modify_damage_roll()
	return dam_mod
