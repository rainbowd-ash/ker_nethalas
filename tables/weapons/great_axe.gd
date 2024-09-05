extends Weapon
class_name GreatAxe

func _init():
	title = "greataxe"
	cost = 50
	damage_type = Damage.damage_types.slashing
	skill = Skills.all_skills.bladed_weapons
	speed = -10
	qualities = [Weapon.all_qualities.twohanded]
	description = ""
