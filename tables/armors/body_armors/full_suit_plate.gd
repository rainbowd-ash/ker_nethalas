extends BodyArmor
class_name FullSuitPlate

func _init():
	title = "plate armor - full suit"
	type = equipment_types.full_suit
	weight = weights.heavy
	cost = 400
	integrity = UsageDie.new("d12")
	protection = 3
	maneuverability = -30
