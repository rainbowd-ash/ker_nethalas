extends ColorRect

var initial_scene : PackedScene = load("res://character_creation/title.tscn")

func _ready():
	%Menu.add_child(initial_scene.instantiate())
