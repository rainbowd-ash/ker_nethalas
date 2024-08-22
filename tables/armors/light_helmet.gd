extends Armor
class_name LightHelmet

var perception_modifier : int = -5

func _init():
	title = "light helmet"
	integrity = Dice.sizes.d6
	equipment_type = equipment_types.head

func modify_perception_skill():
	return perception_modifier
