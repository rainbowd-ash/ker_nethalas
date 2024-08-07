extends CharacterCreationScreen
class_name CharacterCreationAccused

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		next_screen()

func _ready():
	next_screen_scene = load("res://character_creation/title.tscn")
	%AccusedLabel.clear()
	%AccusedLabel.append_text(
		"[center]YOU HAVE BEEN SENTENCED TO DEATH FOR [color=#6a7066]%s[/color][/center]" % AccusedTable.roll().to_upper()
	)
