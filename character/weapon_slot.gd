extends GearSlot

enum hold_states {
	unarmed,
	single_wield,
	dual_wield,
	two_handed,
}
var hold_state : hold_states = hold_states.unarmed

func _ready() -> void:
	update_hold_state()
	valid_equip_types = [
		Equipment.equipment_types.main_hand,
		Equipment.equipment_types.off_hand,]

func update_hold_state() -> hold_states:
	var children = get_children()
	if children.size() == 0:
		hold_state = hold_states.unarmed
	elif children.size() == 1:
		if children[0].qualities.has(Weapon.all_qualities.twohanded):
			hold_state = hold_states.two_handed
			max_equipped = 1
		else:
			hold_state = hold_states.single_wield
			max_equipped = 2
	else:
		hold_state = hold_states.dual_wield
		max_equipped = 2
	return hold_state

func dequip(equipment : Equipment) -> Equipment:
	remove_child(equipment)
	update_hold_state()
	return equipment

func can_equip(equipment : Equipment) -> GearSlot:
	update_hold_state()
	if hold_state == hold_states.two_handed:
		return null
	if equipment.qualities.has(Weapon.all_qualities.twohanded):
		if hold_state == hold_states.single_wield or hold_state == hold_states.dual_wield:
			return null
	return super.can_equip(equipment)



