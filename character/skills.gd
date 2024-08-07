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

func set_skill(skill_title, new_value):
	skills[skill_title].value = new_value

func get_skill_value(skill_title: String):
	return skills[skill_title].get_value()

func get_skills():
	return skills

func get_skills_with_tag(tag : String):
	var result = {}
	for skill in skills:
		if skills[skill].tags.has(tag):
			result[skill] = skills[skill]
	return result
