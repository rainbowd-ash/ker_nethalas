extends Node
class_name Attributes

signal attributes_changed

var health : int = 0 : 
	get:
		return health
	set(value):
		attributes_changed.emit()
		health = value

var max_health : int = 0 :
	get: 
		return max_health
	set(value):
		attributes_changed.emit()
		max_health = value
		
var toughness : int = 0 :
	get: 
		return toughness
	set(value):
		attributes_changed.emit()
		toughness = value

var max_toughness : int = 0 :
	get: 
		return max_toughness
	set(value):
		attributes_changed.emit()
		max_toughness = value

var aether : int = 0 :
	get: 
		return aether
	set(value):
		attributes_changed.emit()
		aether = value
		
var max_aether : int = 0 :
	get: 
		return max_aether
	set(value):
		attributes_changed.emit()
		max_aether = value
		
var sanity : int = 0 :
	get: 
		return sanity
	set(value):
		attributes_changed.emit()
		sanity = value
		
var exhaustion : int = 0 :
	get: 
		return exhaustion
	set(value):
		attributes_changed.emit()
		exhaustion = value
		
var exhaustion_resistance : int = 0 :
	get: 
		return exhaustion_resistance
	set(value):
		attributes_changed.emit()
		exhaustion_resistance = value

var magic_resistance : int = 0 :
	get: 
		return magic_resistance
	set(value):
		attributes_changed.emit()
		magic_resistance = value

func print_all():
	print("All attributes:")
	print("\thealth: " + str(health))
	print("\ttoughness: " + str(toughness))
	print("\taether: " + str(aether))
	print("\tmax_aether: " + str(max_aether))
	print("\tsanity: " + str(sanity))
	print("\texhaustion: " + str(exhaustion))
	print("\texhaustion_resistance: " + str(exhaustion_resistance))
	print("\tmagic_resistance: " + str(magic_resistance))
