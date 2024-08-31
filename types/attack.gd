extends Node
class_name Damage

var damage_type : damage_types
var amount : int = 0
var roll : int = 0

# convert damage dice roll into this much actual damage
# all damage (including traps, events, etc) goes through this conversion
# this conversion happens for EACH DIE
	# 2d6 will convert twice and sum results
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

func setup(type : damage_types, a_roll : int) -> void:
	damage_type = type
	roll = a_roll
	amount = convert_roll_to_damage(roll)

func convert_roll_to_damage(roll : int) -> int:
	for entry in roll_to_damage_table:
		if roll <= entry[0]:
			amount = entry[1]
			break
	return amount
