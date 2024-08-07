extends Node
#class_name Character

var char_name = "default name"
var accused = ""
var skills = Skills.new()
var attributes = Attributes.new()

func _ready():
	skills_init()
	attributes_init()

func skills_init():
	skills.set_skill("acrobatics",10)
	skills.set_skill("athletics",10)
	skills.set_skill("dodge",10)
	skills.set_skill("perception",20)
	skills.set_skill("resolve",10)
	skills.set_skill("fist_weapons",10)

func attributes_init():
	attributes.health = Dice.roll(1, "d6", 8)
	attributes.toughness = Dice.roll(2, "d6", 10)
	attributes.max_aether = Dice.roll(1, "d6", 10)
	attributes.aether = attributes.max_aether
	attributes.magic_resistance = 20
