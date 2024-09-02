extends Node
class_name Monster

signal monster_picked(monster : Monster)

var title = ""
var athletics = 0
var awareness = 0
var combat_skill = 0
var endurance = 0
var health = 0
var magic_resistance = 0
var number = 0
var spoils
var hit_location
var creature_trait
var type
var level_adaption

func _ready() -> void:
	SignalBus.combat_attack.connect(_on_combat_attack)

func do_action(action_key : String):
	if action_key == "monster_pick":
		SignalBus.monster_picked.emit(self)

func actions():
	return null

func get_attack_roll_value():
	return combat_skill

func get_defence_roll_value():
	return combat_skill

func _on_combat_attack(attack):
	if attack.target == self:
		health -= attack.damage.amount
		SignalBus.chat_log.emit("%s takes %d %s damage" % [title, attack.damage.amount, Damage.damage_types.keys()[attack.damage.damage_type]])
		if health <= 0:
			SignalBus.chat_log.emit("%s dies!" % title)
			queue_free()
