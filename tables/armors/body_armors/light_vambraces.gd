extends BodyArmor
class_name LightVambraces

func _init():
	title = "light vambraces"
	type = equipment_types.vambraces
	cost = 10
	protection = 1
	integrity = UsageDie.new("d6")
	maneuverability = -5
