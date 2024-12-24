extends Node

signal health_changed(details)
var health_changed_details = {
	"previous_health" = 0,
	"current_health" = 0,
}

signal player_died(details)
var player_died_details = {}

var current_health
var max_health

func _ready() -> void:
	max_health = Dice.roll("1d6+8")
	current_health = max_health

func details() -> Dictionary:
	return {
		"current_health" = current_health,
		"max_health" = max_health,
	}

func change(amount : int) -> int:
	health_changed_details.previous_health = current_health
	current_health += amount
	if current_health > max_health:
		current_health = max_health
	health_changed_details.current_health = current_health
	health_changed.emit(health_changed_details)
	if current_health <= 0:
		player_died.emit(player_died_details)
	return current_health
