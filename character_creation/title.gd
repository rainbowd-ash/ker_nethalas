extends CharacterCreationScreen
class_name CharacterCreationTitle

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		next_screen()

func _ready():
	next_screen_scene = load("res://character_creation/name.tscn")
