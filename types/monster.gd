extends Node
class_name Monster

var title = ""
var athletics = 0
var awareness = 0
var combat_skill = 0
var endurance = 0
var health = 0
var max_health = 0
var magic_resistance = 0
var number = 0

var spoils
var creature_trait
var type
var level_adaption

var weak_spots : Array[String] = []
var body_plan : BodyPlan = null

var active : bool = true
var default_target : Node

func _ready() -> void:
	SignalBus.attack.connect(_on_attack)
	health = max_health
	default_target = get_parent().get_character_dummy()
	assign_weak_spots()

func assign_weak_spots() -> void:
	for location in weak_spots:
		body_plan.parts[location].weak_spot = true

func get_skill(skill : String):
	match skill:
		"combat":
			return combat_skill
		"attack":
			return (combat_skill - (10 * body_plan.get_disabled_count()))
		"athletics":
			return athletics
		"awareness":
			return awareness
		"endurance":
			return endurance
		"health":
			return health
		"max_health":
			return max_health
		"magic_resistance":
			return magic_resistance

func do_action(action_key : String):
	if action_key == "monster_pick":
		SignalBus.monster_picked.emit(self)
	elif action_key.contains("part_pick-"):
		var substr = action_key.get_slice("-", 1)
		SignalBus.part_picked.emit(body_plan.parts[substr])

func actions():
	return null

func _on_attack(attack):
	if attack.target == self:
		health -= attack.damage.amount
		SignalBus.chat_log.emit("%s takes %d %s damage" % [title, attack.damage.amount, Damage.damage_types.keys()[attack.damage.damage_type]])
		if health <= 0:
			SignalBus.chat_log.emit("%s dies!" % title)
			active = false
			queue_free()

# makes a normal attack against the default target (player)
# will double damage dice (1d4+2 > 2d4+4) on weak spot hit
func build_default_attack(damage_dice : String, damage_type : Damage.damage_types, target : Node = default_target):
	var attack = Attack.new(self,target)
	attack.location = target.body_plan.roll_hit_location()
	attack.damage = Damage.new(Dice.to_damage(damage_dice, attack.location.weak_spot), damage_type)
	return attack
