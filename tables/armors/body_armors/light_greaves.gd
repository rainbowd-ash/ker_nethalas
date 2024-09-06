extends BodyArmor
class_name LightGreaves

func _init():
	title = "light greaves"
	type = equipment_types.greaves
	cost = 10
	protection = 1
	integrity = UsageDie.new("d6")
	maneuverability = -5
