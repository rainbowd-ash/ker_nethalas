extends Node
class_name GearSlot

var valid_equip_types : Array
var max_equipped : int = 1

func get_equipped():
	return get_children()

func can_equip(equipment : Equipment) -> GearSlot:
	if get_children().size() >= max_equipped:
		return null
	for type in valid_equip_types:
		if type == equipment.type:
			return self
	return null

func equip(equipment : Equipment) -> bool:
	var slot = can_equip(equipment)
	if slot:
		add_child(equipment)
		return true
	return false

func dequip(equipment : Equipment) -> Equipment:
	remove_child(equipment)
	return equipment
