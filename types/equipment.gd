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
	ring,
	backpack,
	pouch,
}
var equipment_type : int = -1
var equipped : bool = false
