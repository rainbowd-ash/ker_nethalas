extends Item
class_name Equipment

var equipment_type_strings = [
	"main hand",
	"off_hand",
	"belt",
	"head",
	"armor",
	"cuirass",
	"vambraces",
	"grieves",
	"gloves",
	"boots",
	"amulet",
	"rings",
	"backpack",
	"pouches",
]

enum equipment_types {
	main_hand,
	off_hand,
	belt,
	head,
	armor,
	cuirass,
	vambraces,
	grieves,
	gloves,
	boots,
	amulet,
	rings,
	backpack,
	pouches,
}
var equipment_type : int = -1
var equipped : bool = false

func get_item_details():
	var item_details = super.get_item_details()
	var equipment_details = {
		"equip slot": equipment_type_strings[equipment_type],
	}
	item_details.merge(equipment_details)
	return item_details
