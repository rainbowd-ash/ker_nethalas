class_name BodyPlan

var parts = {}

func roll_hit_location() -> BodyPart:
	return null

func get_disabled_count() -> int:
	var result = 0
	if not parts:
		return result
	for part in parts:
		if parts[part].disabled:
			result += 1
	return result
