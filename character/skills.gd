extends Node
class_name Skills

var skills = {
			 acrobatics = Skill.new("acrobatics", "acrobatics", 0),
			  athletics = Skill.new("athletics", "athletics", 0),
		 bladed_weapons = Skill.new("bladed_weapons", "bladed weapons", 0, ["weapon"]),
	bludgeoning_weapons = Skill.new("bludgeoning_weapons", "bludgeoning weapons", 0, ["weapon"]),
				  dodge = Skill.new("dodge", "dodge", 0),
			  endurance = Skill.new("endurance", "endurance", 0),
			   medicine = Skill.new("medicine", "medicine", 0),
			 perception = Skill.new("perception", "perception", 0),
				resolve = Skill.new("resolve", "resolve", 0),
				 reason = Skill.new("reason", "reason", 0),
			   scavenge = Skill.new("scavenge", "scavenge", 0),
		shafted_weapons = Skill.new("shafted_weapons", "shafted weapons", 0, ["weapon"]),
				stealth = Skill.new("stealth", "stealth", 0),
			   thievery = Skill.new("thievery", "thievery", 0),
		   fist_weapons = Skill.new("fist_weapons", "fist weapons", 0, ["weapon"]),
}

func set_skill(skill : String, new_value : int) -> void:
	skills[skill].value = new_value

# TODO: make derived skills (attack, defence, initiative) just normal skills?
	# might make it hard to keep them updated
func get_skill(skill : String, include_modifiers : bool = true) -> int:
	if not _valid_skill_title(skill):
		push_error("get_skill() called on invalid skill title")
		return 0
	var base_value : int = 0
	var modify_amount = _modify_skill_amount(skill)
	if skills.has(skill):
		base_value = skills[skill].value
	# special cases for derived skills "attack", "defence", "initiative"
	match skill:
		"attack": # checks main hand weapon
			base_value = skills[Character.gear.get_weapons()[0].skill].value
		"defence": # compares dodge and mainhand weapon and sets the highest
			var dodge = skills["dodge"].value
			var weapon = skills[Character.gear.get_weapons()[0].skill].value
			if dodge > weapon:
				base_value = dodge
			else:
				base_value = weapon
		"initiative":
			base_value = skills["perception"].value
	if skill == "defence" and include_modifiers:
		# special case! defence check -- dodge+mods compared to weapon+mods
		# TODO: better way to do this?
		# modify_amount = _modify_skill_amount("defence")
		var weapon_skill : Skill = skills[Character.gear.get_weapons()[0].skill]
		var dodge_sum : int = skills["dodge"].value + modify_amount + _modify_skill_amount("dodge")
		var weapon_sum : int = weapon_skill.value + modify_amount + _modify_skill_amount(weapon_skill.title)
		if dodge_sum > weapon_sum:
			modify_amount += _modify_skill_amount("dodge")
		else:
			modify_amount += _modify_skill_amount(weapon_skill.title)
	if not include_modifiers:
	# this does a lot of extra math to just return base value, but I like having it at the bottom
		return base_value
	return base_value + modify_amount

# returns sum of modifications to skill
func _modify_skill_amount(skill : String) -> int:
	var mod_value : int = 0
	mod_value += Character.gear.modify_skill(skill)
	if Router.game_modes.get_current_mode() == "CombatMode":
		mod_value += Router.combat.get_character_dummy().modify_skill(skill)
	return mod_value

func get_skills() -> Dictionary:
	return skills

func get_skills_with_tag(tag : String) -> Dictionary:
	var result = {}
	for skill in skills:
		if skills[skill].tags.has(tag):
			result[skill] = skills[skill]
	return result

func _valid_skill_title(skill : String) -> bool:
	if skills.has(skill):
		return true
	match skill:
		"attack", "defence", "initiative":
			return true
	return false
