extends Node
class_name Attributes

signal attributes_changed

var health : int = 0 : 
	get:
		return health
	set(value):
		health = value
		attributes_changed.emit()

var max_health : int = 0 :
	get: 
		return max_health
	set(value):
		max_health = value
		attributes_changed.emit()
		
var toughness : int = 0 :
	get: 
		return toughness
	set(value):
		toughness = value
		attributes_changed.emit()

var max_toughness : int = 0 :
	get: 
		return max_toughness
	set(value):
		max_toughness = value
		attributes_changed.emit()

var aether : int = 0 :
	get: 
		return aether
	set(value):
		aether = value
		attributes_changed.emit()
		
var max_aether : int = 0 :
	get: 
		return max_aether
	set(value):
		max_aether = value
		attributes_changed.emit()
		
var sanity : int = 0 :
	get: 
		return sanity
	set(value):
		sanity = value
		attributes_changed.emit()
		
var exhaustion : int = 0 :
	get: 
		return exhaustion
	set(value):
		exhaustion = value
		attributes_changed.emit()
		
var exhaustion_resistance : int = 0 :
	get: 
		return exhaustion_resistance
	set(value):
		exhaustion_resistance = value
		attributes_changed.emit()

var magic_resistance : int = 0 :
	get: 
		return magic_resistance
	set(value):
		magic_resistance = value
		attributes_changed.emit()

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
