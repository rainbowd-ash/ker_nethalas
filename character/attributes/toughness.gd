extends Node

signal toughness_changed(details)
var toughness_changed_details = {
	"previous_toughness" = 0,
	"current_toughness" = 0,
}

var current_toughness
var max_toughness

func _ready() -> void:
	max_toughness = Dice.roll("1d6+8")
	current_toughness = max_toughness

func details() -> Dictionary:
	return {
		"current_toughness" = current_toughness,
		"max_toughness" = max_toughness,
	}

func change(amount : int) -> int:
	toughness_changed_details.previous_toughness = current_toughness
	current_toughness += amount
	if current_toughness > max_toughness:
		current_toughness = max_toughness
	toughness_changed_details.current_toughness = current_toughness
	toughness_changed.emit(toughness_changed_details)
	return current_toughness
