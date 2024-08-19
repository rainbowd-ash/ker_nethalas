extends CharacterCreationScreen
class_name SkillsSelection

@export var skills_button : PackedScene

var skill_point_allotment_index = 0
var skill_point_allotments = [
	[60, "weapon"],
	[40, "weapon"],
	[30],
	[30],
	[30],
	[20],
	[20],
	[20],
	[10],
	[10],
	[10],
	[10],
]

func _ready():
	next_screen_scene = load("res://character_creation/accused.tscn")
	var character_skills = Character.skills.get_skills()
	for skill in character_skills:
		var new_button = skills_button.instantiate()
		new_button.build(self, character_skills[skill])
		new_button.pressed.connect(_on_skills_button_pressed)
		%ButtonContainer.add_child(new_button)
	if skill_point_allotments[skill_point_allotment_index].size() > 1:
		filter_buttons_by_tag(skill_point_allotments[skill_point_allotment_index][1])
	focus_valid_button()

func get_current_allotment_size():
	return skill_point_allotments[skill_point_allotment_index][0]

func _on_skills_button_pressed():
	skill_point_allotment_index += 1
	if skill_point_allotment_index >= skill_point_allotments.size():
		finalize_selection()
		next_screen()
		return
	if skill_point_allotments[skill_point_allotment_index].size() > 1:
		filter_buttons_by_tag(skill_point_allotments[skill_point_allotment_index][1])
	else: filter_buttons_by_tag("")
	focus_valid_button()

func filter_buttons_by_tag(tag : String):
	if tag.is_empty():
		for button in %ButtonContainer.get_children():
			button.show()
		return
	for button in %ButtonContainer.get_children():
		if button.skill.tags.has(tag):
			button.show()
		else:
			button.hide()

func focus_valid_button():
	for button in %ButtonContainer.get_children():
		if button.is_visible() and not button.is_disabled():
			button.grab_focus()
			return

func finalize_selection():
	for button in %ButtonContainer.get_children():
		if button.is_disabled():
			Character.skills.set_value(button.skill.title, button.new_value)
