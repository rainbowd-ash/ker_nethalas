extends BodyPlan
class_name BodyPlanHumanoid

func _init() -> void:
	parts = {
		right_leg = BodyPart.new("right leg"),
		left_leg = BodyPart.new("left leg"),
		abdomen = BodyPart.new("abdomen"),
		chest = BodyPart.new("chest"),
		left_arm = BodyPart.new("left arm"),
		right_arm = BodyPart.new("right arm"),
		head = BodyPart.new("head")
	}

func roll_hit_location() -> BodyPart:
	var roll : int = Dice.roll("1d20")
	match roll:
		1, 2, 3:
			return parts["right_leg"]
		4, 5, 6:
			return parts["left_leg"]
		7, 8, 9:
			return parts["abdomen"]
		10, 11, 12:
			return parts["chest"]
		13, 14, 15:
			return parts["left_arm"]
		16, 17, 18:
			return parts["right_arm"]
		19, 20:
			return parts["head"]
	push_error("roll hit location returned null")
	return null
