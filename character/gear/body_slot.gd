extends GearSlot

var full_suit : Armor = null
var torso : Armor = null
var vambraces : Armor = null
var greaves : Armor = null

func can_equip(armor : Equipment) -> GearSlot:
	if armor is not Armor:
		return null
	if armor.type == Equipment.equipment_types.full_suit:
		if torso != null or vambraces != null or greaves != null:
			return null # piecemeal equipped
		return self
	elif armor.type == Equipment.equipment_types.torso and not torso:
		return self
	elif armor.type == Equipment.equipment_types.vambraces and not vambraces:
		return self
	elif armor.type == Equipment.equipment_types.greaves and not greaves:
		return self
	return null

func equip(armor : Equipment) -> bool:
	if not can_equip(armor):
		return false
	if armor.type == Equipment.equipment_types.full_suit:
		full_suit = armor
	elif armor.type == Equipment.equipment_types.torso:
		torso = armor
	elif armor.type == Equipment.equipment_types.vambraces:
		vambraces = armor
	elif armor.type == Equipment.equipment_types.greaves:
		greaves = armor
	add_child(armor)
	return true

func dequip(armor : Equipment) -> Equipment:
	var return_armor = null
	if armor == full_suit:
		return_armor = full_suit
		remove_child(armor)
		full_suit = null
	elif armor == torso:
		return_armor = torso
		remove_child(torso)
		torso = null
	elif armor == vambraces:
		return_armor = vambraces
		remove_child(vambraces)
		vambraces = null
	elif armor == greaves:
		return_armor = greaves
		remove_child(greaves)
		greaves = null
	return return_armor
