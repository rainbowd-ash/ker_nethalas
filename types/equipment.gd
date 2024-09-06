extends Item
class_name Equipment

enum equipment_types {
	main_hand,
	off_hand,
	belt,
	head,
	full_suit,
	torso, # body
	vambraces, # arms
	greaves, # legs
	gloves,
	boots,
	amulet,
	ring,
}
var type : equipment_types
