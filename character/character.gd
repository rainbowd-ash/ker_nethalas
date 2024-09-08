extends Node
#class_name Character

var char_name = "default name"
var accused = ""
@onready var skills = $Skills
@onready var attributes = $Attributes
@onready var inventory = $Inventory
@onready var gear = $Gear

func _ready():
	SignalBus.attack.connect(_on_attack)
	
	attributes.max_health = Dice.roll("1d6+8")
	attributes.health = attributes.max_health
	attributes.max_toughness = Dice.roll("1d6+10")
	attributes.toughness = attributes.max_toughness
	attributes.max_aether = Dice.roll("1d6+8")
	attributes.aether = attributes.max_aether
	attributes.magic_resistance = 20
	skills.set_skill("acrobatics",10)
	skills.set_skill("athletics",10)
	skills.set_skill("dodge",10)
	skills.set_skill("perception",20)
	skills.set_skill("resolve",10)
	skills.set_skill("fist_weapons",10)
	# debug test values
	skills.set_skill("scavenge",50)
	skills.set_skill("perception",70)
	skills.set_skill("stealth", 80)
	skills.set_skill("fist_weapons", 40)
	skills.set_skill("bladed_weapons", 10)
	skills.set_skill("shafted_weapons", 20)
	skills.set_skill("bludgeoning_weapons", 30)

func _on_attack(attack : Attack):
	if attack.target == self:
		var output_string = "you take %d %s damage" % [attack.damage.amount, Damage.damage_types.keys()[attack.damage.damage_type]]
		if attack.location:
			output_string += " to the %s" % [attack.location.title]
		var remaining_damage : int = attack.damage.amount
		SignalBus.chat_log.emit(output_string + "!")
		if remaining_damage >= attributes.toughness:
			remaining_damage -= attributes.toughness
			attributes.toughness = 0
		else:
			attributes.toughness -= remaining_damage
			remaining_damage = 0
		if remaining_damage:
			attributes.health -= remaining_damage
			remaining_damage = 0
		death_check()
	return

func death_check():
	if attributes.health == 0:
		SignalBus.chat_log.emit("YOU DIED")

# might move this to gear.get_weapons()
func get_unarmed_weapon() -> Weapon:
	var fists : Weapon = Weapon.new(
		Damage.damage_types.bludgeoning, 
		"fist_weapons"
		)
	fists.title = "fists"
	return fists
