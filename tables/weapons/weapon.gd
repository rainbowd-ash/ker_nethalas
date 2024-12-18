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
var die : String = "1d6"
var damage_type : Damage.damage_types
var skill : String
var speed = 0

func _init(a_damage_type : Damage.damage_types, a_skill : String) -> void:
	Character.skills._valid_skill_title(a_skill)
	damage_type = a_damage_type
	skill = a_skill

func get_speed():
	return speed

# stat modification methods
# ===================================================================
func modify_skill(skill : String) -> int:
	match skill:
		"attack":
			return modify_attack_skill()
		"defence":
			return modify_defence_skill()
		"initiative":
			return modify_initiative_skill()
	return 0

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
	if qualities.has(all_qualities.versatile):
		if get_parent().wield_state() == "single wield":
			mod += 1
	if qualities.has(all_qualities.twohanded):
		mod += 1
	if qualities.has(all_qualities.powerful):
		mod += 1
	return mod
