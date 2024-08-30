extends Node
class_name Monster

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

func actions():
	return null

func get_attack_value():
	return combat_skill

func do_action():
	return
