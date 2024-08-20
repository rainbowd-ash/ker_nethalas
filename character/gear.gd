extends Node
class_name Gear

var equipped = {
	"main_hand": null,
	"off_hand": null,
	"belt": null,
	"head": null,
	"armor": {
		"cuirass": null, # body armor
		"vambraces": null, # arm armor
		"grieves": null, # leg armor
	},
	"gloves": null,
	"boots": null,
	"amulet": null,
	"rings": [null, null],
	"backpack": null,
	"pouches": [null, null,null]
}

# stat modification methods
# ===================================================================
func get_carry_capacity():
	var cap_mod = 0
	for gear in equipped:
		if gear.has_method("modify_max_inventory_size"):
			cap_mod += gear.modify_max_inventory_size()
	return cap_mod + %Inventory.base_capacity
