extends Node
class_name Damage

var damage_type : damage_types
var amount : int = 0
var roll : int = 0

# convert damage dice roll into this much actual damage
# all damage (attacks, traps, events, etc) goes through this conversion
	# attack rolls '3d6+1 damage'
	# roll of 3d6 results in 3, 4, 5
	# add the +1 to 3 (lowest number) resulting in 4, 4, 5
	# through table below this converts to 1, 1, 2 = 4 damage
# [1, 0] # convert a roll of 1 or lower to 0 damage
# [4, 1] # convert a roll of 2, 3, or 4 to 1 damage
const roll_to_damage_table = [
	[1, 0],
	[4, 1],
	[7, 2],
	[9, 3],
	[100, 4],
]

enum damage_types {
	acid,
	air,
	arcane,
	bludgeoning,
	cold,
	earth,
	fire,
	holy,
	infernal,
	necrotic,
	piercing,
	poison,
	psychic,
	slashing,
	water,
}

func _init(type : damage_types, a_roll : int) -> void:
	damage_type = type
	roll = a_roll
	amount = convert_roll_to_damage(roll)

func convert_roll_to_damage(roll : int) -> int:
	for entry in roll_to_damage_table:
		if roll <= entry[0]:
			amount = entry[1]
			break
	return amount
