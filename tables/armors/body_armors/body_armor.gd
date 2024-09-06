extends Armor
class_name BodyArmor

# affects acrobatics, dodge, and stealth skills
var maneuverability : int = -30

func modify_skill(skill : String):
	match skill:
		"acrobatics", "dodge", "stealth":
			return maneuverability
