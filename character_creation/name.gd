extends CharacterCreationScreen
class_name CharacterCreationName

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		next_screen()

func _ready():
	next_screen_scene = load("res://character_creation/skills_selection.tscn")
	%NameEntry.grab_focus()

func _on_name_entry_text_submitted(new_text):
	if not new_text.is_empty():
		Character.char_name = new_text
		next_screen()
