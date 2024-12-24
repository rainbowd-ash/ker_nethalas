extends Node

signal sanity_changed(details)
var sanity_changed_details = {
	"previous_sanity" = 0,
	"current_sanity" = 0,
}

var current_sanity
var max_sanity

func _ready() -> void:
	max_sanity = Dice.roll("1d6+8")
	current_sanity = max_sanity

func details() -> Dictionary:
	return {
		"current_sanity" = current_sanity,
		"max_sanity" = max_sanity,
	}

func change(amount : int) -> int:
	sanity_changed_details.previous_sanity = current_sanity
	current_sanity += amount
	if current_sanity > max_sanity:
		current_sanity = max_sanity
	sanity_changed_details.current_sanity = current_sanity
	sanity_changed.emit(sanity_changed_details)
	return current_sanity
