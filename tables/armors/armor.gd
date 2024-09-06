extends Equipment
class_name Armor

var protection : int = 0
var integrity : UsageDie = UsageDie.new("d4")

func get_item_details():
	var equipment_details = super.get_item_details()
	var armor_details = {
		"protection": protection,
		"integrity": "d%d" % integrity,
	}
	equipment_details.merge(armor_details)
	return equipment_details
