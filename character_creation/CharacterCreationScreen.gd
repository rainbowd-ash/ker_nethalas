extends Control
class_name CharacterCreationScreen

var next_screen_scene : PackedScene

func next_screen():
	add_sibling(next_screen_scene.instantiate())
	queue_free()
