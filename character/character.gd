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
	# debug test values
	skills.set_skill("scavenge",50)
	skills.set_skill("perception",70)
	skills.set_skill("stealth", 80)
	skills.set_skill("fist_weapons", 40)
	skills.set_skill("bladed_weapons", 80)
	skills.set_skill("shafted_weapons", 20)
	skills.set_skill("bludgeoning_weapons", 30)

func _on_attack(attack : Attack):
	if attack.target == self:
		var output_string = "you take %d %s damage" % [attack.damage.amount, Damage.damage_types.keys()[attack.damage.damage_type]]
		if attack.location:
			output_string += " to the %s" % [attack.location.title]
		SignalBus.chat_log.emit(output_string + "!")
		take_damage(attack)
	return

func take_damage(attack : Attack):
	var unallocated_damage : int = attack.damage.amount
	var toughness = attributes.toughness.details()
	if unallocated_damage >= toughness.current_toughness:
		unallocated_damage -= toughness.current_toughness
		attributes.toughness.change(toughness.current_toughness * -1)
	else:
		attributes.toughness.change(toughness.current_toughness * -1)
		unallocated_damage = 0
	if unallocated_damage:
		attributes.health.change(-1 * unallocated_damage)
		unallocated_damage = 0

func light_check() -> void:
	if gear.equipped_light.light_remaining():
		return
	var check : CheckResult = skills.check("resolve")
	if not check.success:
		attributes.sanity.change(-1)
		# TODO gain status effect blinded

# might move this to gear.get_weapons()
func get_unarmed_weapon() -> Weapon:
	var fists : Weapon = Weapon.new(
		Damage.damage_types.bludgeoning, 
		"fist_weapons"
		)
	fists.title = "fists"
	return fists
