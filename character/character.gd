extends Node
#class_name Character

var char_name = "default name"
var accused = ""
@onready var skills = $Skills
@onready var attributes = $Attributes
@onready var inventory = $Inventory
@onready var gear = $Gear

func _ready():
	SignalBus.combat_attack.connect(_on_combat_attack)
	
	attributes.max_health = Dice.roll("1d6+8")
	attributes.health = attributes.max_health
	attributes.max_toughness = Dice.roll("1d6+10")
	attributes.toughness = attributes.max_toughness
	attributes.max_aether = Dice.roll("1d6+8")
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
	skills.set_value("bladed_weapons", 10)
	skills.set_value("shafted_weapons", 20)
	skills.set_value("bludgeoning_weapons", 30)

func _on_combat_attack(attack : CombatAttack):
	if attack.target == self:
		var remaining_damage : int = attack.damage.amount
		SignalBus.chat_log.emit("you take %d %s damage" % [attack.damage.amount, Damage.damage_types.keys()[attack.damage.damage_type]])
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
		Skills.all_skills.fist_weapons
		)
	fists.title = "fists"
	return fists
