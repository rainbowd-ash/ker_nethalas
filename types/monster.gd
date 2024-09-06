extends Node
class_name Monster

signal monster_picked(monster : Monster)

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
var hit_location
var creature_trait
var type
var level_adaption

var active : bool = true
var default_target : Node

func _ready() -> void:
	SignalBus.attack.connect(_on_attack)
	health = max_health
	default_target = get_parent().get_character_dummy()

func get_skill(skill : String):
	match skill:
		"combat":
			return combat_skill
		"athletics":
			return athletics
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
