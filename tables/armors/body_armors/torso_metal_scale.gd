extends BodyArmor
class_name TorsoMetalScale

func _init():
	title = "metal scale - torso armor"
	type = equipment_types.torso
	cost = 150
	protection = 2
	integrity = UsageDie.new("d10")
	maneuverability = -20
