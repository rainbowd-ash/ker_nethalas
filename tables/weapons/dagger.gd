extends Weapon
class_name Dagger

func _init():
	title = "dagger"
	cost = 5
	damage_type = Damage.damage_types.piercing
	skill = "bladed_weapons"
	speed = 10
	qualities = [Weapon.all_qualities.quick]
	description = ""
