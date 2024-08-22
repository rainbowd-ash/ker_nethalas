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

func modify_defense_check():
	if qualities.has(all_qualities.parrying):
		return 10

func modify_initiative_check():
	if qualities.has(all_qualities.quick):
		return 10
