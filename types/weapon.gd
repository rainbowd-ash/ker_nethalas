extends Equipment
class_name Weapon

enum all_qualities {
	defensive,
	quick,
	parrying,
	powerful,
	simple,
	twohanded,
	versatile,
}

var qualities = []
var die_size : String = "d6"
var die_quantity : int = 1
var damage_type : Damage.damage_types
var skill : Skills.all_skills
var speed = 0

func _init(a_damage_type : Damage.damage_types, a_skill : Skills.all_skills) -> void:
	damage_type = a_damage_type
	skill = a_skill

func get_speed():
	return speed

# stat modification methods
# ===================================================================
func modify_defence_skill() -> int:
	var mod = 0
	#if qualities.has(all_qualities.defensive) and Character.gear.has_shield():
		#mod += 10
	if qualities.has(all_qualities.parrying):
		mod += 10
	return mod

func modify_attack_skill() -> int:
	var mod = 0
	if qualities.has(all_qualities.simple):
		mod += 10
	return mod

func modify_initiative_skill() -> int:
	var mod = 0
	if qualities.has(all_qualities.quick):
		mod += 10
	return mod

func modify_damage_roll() -> int:
	var mod = 0
	if qualities.has(all_qualities.versatile): # TODO fix this to check for offhand
		mod += 1
	if qualities.has(all_qualities.twohanded):
		mod += 1
	if qualities.has(all_qualities.powerful):
		mod += 1
	return mod
