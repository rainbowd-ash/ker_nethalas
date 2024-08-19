extends Area2D
class_name Door

# return door node that is overlapping
func get_paired_door():
	if has_overlapping_areas():
		return get_overlapping_areas()[0]

func set_label(text : String):
	$Label.set_text(text)
