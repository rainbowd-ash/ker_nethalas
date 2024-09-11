extends GearSlot

func light_remaining() -> int:
	if not get_equipped():
		return 0
	if get_equipped()[0].has_method("light_remaining"):
		return get_children()[0].light_remaining()
	else: return 0
