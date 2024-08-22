extends Item
class_name Equipment

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
var equipment_actions = [
	"equip",
	"unequip"
]

func get_actions():
	return item_actions + equipment_actions
