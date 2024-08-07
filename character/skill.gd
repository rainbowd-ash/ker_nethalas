class_name Skill

var title : String
var label : String
var value : int
var tags = []

func get_value():
	return value

func set_value(new_value):
	value = new_value

func _init(new_title : String, new_label : String, new_value : int, new_tags : Array = []):
	title = new_title
	label = new_label
	value = new_value
	tags = new_tags
