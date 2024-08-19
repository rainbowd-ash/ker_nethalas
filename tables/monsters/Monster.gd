class_name Monster
extends Node

var stat_block = {
	title = "",
	athletics = 0,
	awareness = 0,
	combat_skill = 0,
	endurance = 0,
	health = 0,
	magic_resistance = 0,
	number = 0,
}


var spoils
var hit_location
var creature_trait
var type
var level_adaption

func actions():
	print("actions")

func get_stat_value(stat_title : String):
	return stat_block[stat_title]
