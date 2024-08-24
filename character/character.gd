extends Node
#class_name Character

signal performed_standard_action(details : Dictionary)
signal performed_free_action(details : Dictionary)

var char_name = "default name"
var accused = ""
@onready var skills = $Skills
@onready var attributes = $Attributes
@onready var inventory = $Inventory

func _ready():
	skills.set_value("acrobatics",10)
	attributes.health = Dice.roll(1, "d6", 8)
	attributes.toughness = Dice.roll(2, "d6", 10)
	attributes.max_aether = Dice.roll(1, "d6", 10)
	attributes.aether = attributes.max_aether
	attributes.magic_resistance = 20
	skills.set_value("athletics",10)
	skills.set_value("dodge",10)
	skills.set_value("perception",20)
	skills.set_value("resolve",10)
	skills.set_value("fist_weapons",10)
	# debug test values
	skills.set_value("scavenge",50)
	skills.set_value("perception",70)
	skills.set_value("stealth", 80)

func do_action(action_title : String):
	if action_title == "attack":
		print("player attacks")
		performed_standard_action.emit()

func get_standard_actions() -> Array:
	return [
		Action.new(self,"attack"),
	]

func get_free_actions() -> Array:
	return []
