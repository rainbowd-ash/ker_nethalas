extends Sprite2D
class_name Room

var items = [Torch.new(), Backpack.new()]

func get_doors():
	var return_array = []
	for child in get_children():
		if child is Door:
			# MAJOR ASSUMPTION ALERT
			# A DOOR WILL ONLY EVER COLIDE WITH ONE OTHER DOOR????
			return_array.push_back(child.get_paired_door())
	return return_array

func get_items():
	return items

func remove_item(item : Item):
	if items.has(item):
		items.erase(item)
