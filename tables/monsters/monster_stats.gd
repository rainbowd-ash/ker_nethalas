extends Resource
class_name MonsterStats

@export var title : String
@export var athletics : int
@export var awareness : int
@export var combat_skill : int
@export var endurance : int
@export var health : int
@export var magic_resistance : int
@export var number : int

var spoils
var hit_location
var creature_trait
var type
var level_adaption

#func _init(p_title = "", p_number = 0, p_awareness = 0, p_endurance = 0, p_athletics = 0, p_health = 0, p_combat_skill = 0, p_magic_resistance = 0):
	#title = p_title
	#number = p_number
	#awareness = p_awareness
	#endurance = p_endurance
	#athletics = p_athletics
	#health = p_health
	#combat_skill = p_combat_skill
	#magic_resistance = p_magic_resistance
