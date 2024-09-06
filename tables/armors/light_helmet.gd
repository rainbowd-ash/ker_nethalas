extends Armor
class_name LightHelmet

var perception_modifier : int = -5

func _init():
	title = "light helmet"
	cost = 20
	integrity = UsageDie.new("d6")
	protection = 1
	type = equipment_types.head

func modify_perception_skill():
	return perception_modifier
