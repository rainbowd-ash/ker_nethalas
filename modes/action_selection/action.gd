extends Node
class_name Action

var source_node : Node
var title : String # string to put on action list ui
var key : String # key to send to do_action() function 

func _init(a_source_node : Node, a_title : String, a_key : String = "") -> void:
	source_node = a_source_node
	title = a_title
	key = a_key
