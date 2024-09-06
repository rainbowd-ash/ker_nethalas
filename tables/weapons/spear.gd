extends Weapon
class_name Spear

func _init():
	title = "spear"
	cost = 10
	damage_type = Damage.damage_types.piercing
	skill = "shafted_weapons"
	speed = 5
	qualities = [Weapon.all_qualities.defensive, Weapon.all_qualities.versatile]
	description = ""
