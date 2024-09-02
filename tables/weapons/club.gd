extends Weapon
class_name Club

func _init():
	title = "club"
	cost = 5
	damage_type = Damage.damage_types.bludgeoning
	skill = Skills.all_skills.bludgeoning_weapons
	speed = 5
	qualities = [Weapon.all_qualities.simple]
	description = ""
