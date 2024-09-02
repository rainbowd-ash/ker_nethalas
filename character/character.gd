extends Node
#class_name Character

var char_name = "default name"
var accused = ""
@onready var skills = $Skills
@onready var attributes = $Attributes
@onready var inventory = $Inventory
@onready var gear = $Gear

func _ready():
	attributes.max_health = Dice.roll(1, "d6", 8)
	attributes.health = attributes.max_health
	attributes.toughness = Dice.roll(2, "d6", 10)
	attributes.max_aether = Dice.roll(1, "d6", 10)
	attributes.aether = attributes.max_aether
	attributes.magic_resistance = 20
	skills.set_value("acrobatics",10)
	skills.set_value("athletics",10)
	skills.set_value("dodge",10)
	skills.set_value("perception",20)
	skills.set_value("resolve",10)
	skills.set_value("fist_weapons",10)
	# debug test values
	skills.set_value("scavenge",50)
	skills.set_value("perception",70)
	skills.set_value("stealth", 80)
	skills.set_value("fist_weapons", 80)
	
