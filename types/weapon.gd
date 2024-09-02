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
var damage_type = null
var skill = null
var speed = 0

# stat modification methods
# ===================================================================
func modify_defense_skill() -> int:
	var mod = 0
	if qualities.has(all_qualities.defensive) and Character.gear.has_shield():
		mod += 10
	if qualities.has(all_qualities.parrying):
		mod += 10
	return mod

func modify_attack_skill() -> int:
	var mod = 0
	if qualities.has(all_qualities.simple):
		mod += 10
	return mod

func modify_initiative_value() -> int:
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
