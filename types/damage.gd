extends Node
class_name Damage

var damage_type : damage_types
var amount : int = 0

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

func _init(a_amount : int, type : damage_types) -> void:
	amount = a_amount
	damage_type = type
