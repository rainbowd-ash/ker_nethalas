extends Node
class_name Gear

var equipped = {
	"main_hand": null,
	"off_hand": null,
	"belt": null,
	"head": null,
	"armor": null, # full armor
	"cuirass": null, # body armor
	"vambraces": null, # arm armor
	"grieves": null, # leg armor
	"gloves": null,
	"boots": null,
	"amulet": null,
	"ring0": null,
	"ring1": null,
	"backpack": null,
	"pouch0": null,
	"pouch1": null,
	"pouch2": null,
}

# stat modification methods
# ===================================================================
func get_carry_capacity():
	var cap_mod = 0
	for gear in equipped:
		if gear.has_method("modify_max_inventory_size"):
			cap_mod += gear.modify_max_inventory_size()
	return cap_mod + %Inventory.base_capacity

# return true for success and false if not
func equip(equipment : Equipment) -> bool:
	var equipment_type : String = Equipment.equipment_types.keys()[equipment.equipment_type]
	if equipment_type == "ring":
		if not equipped["ring0"]:
			equipped["ring0"] = equipment
			return true
		else:
			if not equipped["ring1"]:
				equipped["ring1"] = equipment
				return true
	elif equipment_type == "pouch":
		if not equipped["pouch0"]:
			equipped["pouch0"] = equipment
			return true
		elif not equipped["pouch1"]:
			equipped["pouch1"] = equipment
			return true
		elif not equipped["pouch2"]:
			equipped["pouch2"] = equipment
			return true
	elif not equipped[equipment_type]:
		print("equipped: %s" % equipment.title)
		equipped[equipment_type] = equipment
		return true
	return false

func unequip_slot(slot : String):
	SignalBus.unequipped_gear.emit()
	Character.inventory.add_item(equipped[slot])
	equipped[slot] = null
