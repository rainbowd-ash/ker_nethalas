class_name Action

var source_node : Node
var key : String # key to send to do_action() function 
var title : String # string to put on action list ui
var active : bool = true # disable button if inactive

func _init(a_source_node : Node, a_key : String, a_title : String = "") -> void:
	source_node = a_source_node
	key = a_key
	if a_title == "":
		title = a_key
	else:
		title = a_title
