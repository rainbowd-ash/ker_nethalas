extends Button
class_name SkillsButton

var skill : Skill
var parent : Node
var new_value : int = 0

func build(assigned_parent, assigned_skill : Skill):
	skill = assigned_skill
	parent = assigned_parent
	text = "%s %d" % [skill.title, skill.value]

func _on_focus_entered():
	if not disabled:
		text = "%s %d" % [
			skill.title, 
			skill.value + parent.get_current_allotment_size(),
		]

func _on_focus_exited():
	if not disabled:
		text = "%s %d" % [skill.title, skill.value]

func _on_pressed():
	new_value = skill.value + parent.get_current_allotment_size()
	disabled = true
	focus_mode = Control.FOCUS_NONE
