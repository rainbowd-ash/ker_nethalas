extends BodyPlan
class_name BodyPlanQuadraped

func _init() -> void:
	parts = {
		right_hind_leg = BodyPart.new("right hind leg"),
		left_hind_leg = BodyPart.new("left hind leg"),
		hindquarters = BodyPart.new("hindquarters"),
		forequarters = BodyPart.new("forequarters"),
		right_front_leg = BodyPart.new("right front leg"),
		left_front_leg = BodyPart.new("left front leg"),
		head = BodyPart.new("head")
	}

func roll_hit_location() -> BodyPart:
	var roll : int = Dice.roll("1d20")
	match roll:
		1, 2, 3:
			return parts["right_hind_leg"]
		4, 5, 6:
			return parts["left_hind_leg"]
		7, 8, 9:
			return parts["hindquarters"]
		10, 11, 12:
			return parts["forequarters"]
		13, 14, 15:
			return parts["right_front_leg"]
		16, 17, 18:
			return parts["left_front_leg"]
		19, 20:
			return parts["head"]
	push_error("roll hit location returned null")
	return null
