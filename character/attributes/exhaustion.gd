extends Node

signal exhaustion_changed(details)
var exhaustion_changed_details = {
	"previous_exhaustion" = 0,
	"current_exhaustion" = 0,
}

var current_exhaustion
var max_exhaustion

func _ready() -> void:
	max_exhaustion = Dice.roll("1d6+8")
	current_exhaustion = max_exhaustion

func details() -> Dictionary:
	return {
		"current_exhaustion" = current_exhaustion,
		"max_exhaustion" = max_exhaustion,
	}

func change(amount : int) -> int:
	exhaustion_changed_details.previous_exhaustion = current_exhaustion
	current_exhaustion += amount
	if current_exhaustion > max_exhaustion:
		current_exhaustion = max_exhaustion
	exhaustion_changed_details.current_exhaustion = current_exhaustion
	exhaustion_changed.emit(exhaustion_changed_details)
	return current_exhaustion
