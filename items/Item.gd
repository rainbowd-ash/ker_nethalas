extends Node
class_name Item

enum weights {
	light, # can stack to 10
	normal, # single slot
	heavy # takes 2 slots
}

var title : String = "default_title"
var weight : int = weights.normal
var cost : int = 0
var description : String = "default_description"

func consume_item():
	queue_free()

