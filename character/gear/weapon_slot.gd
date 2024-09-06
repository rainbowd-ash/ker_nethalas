extends GearSlot

var left_hand: Weapon = null
var right_hand: Weapon = null

func is_single_wielding() -> bool:
	if (left_hand and not right_hand) or (right_hand and not left_hand):
		return true
	return false

func can_equip(weapon : Equipment) -> GearSlot:
	if weapon is not Weapon:
		return null
	if weapon.qualities.has(Weapon.all_qualities.twohanded):
		if left_hand != null or right_hand != null:
			return null
		return self
	else:
		if left_hand != null and right_hand != null:
			return null
		elif left_hand == null:
			return self
		elif right_hand == null:
			return self
	return null

func equip(weapon : Equipment) -> bool:
	if not can_equip(weapon):
		return false
	if weapon.qualities.has(Weapon.all_qualities.twohanded):
		left_hand = weapon
		right_hand = weapon  # Both hands are occupied by the two-handed weapon
	if left_hand == null:
		left_hand = weapon
	elif right_hand == null:
		right_hand = weapon
	add_child(weapon)
	return true

func dequip(weapon : Equipment) -> Equipment:
	var return_weapon = null
	if weapon.qualities.has(Weapon.all_qualities.twohanded) and weapon == left_hand:
		return_weapon = left_hand
		left_hand = null
		right_hand = null
		remove_child(weapon)
	if weapon == left_hand:
		return_weapon = left_hand
		left_hand = null
		remove_child(weapon)
	if weapon == right_hand:
		return_weapon = right_hand
		right_hand = null
		remove_child(weapon)
	return return_weapon
