extends Item
class_name Torch

var turns_remaining : int = 20

func _ready():
	title = "torch"
	weight = weights.light
	cost = 10
	update_description()

# triggers every time player enters a room
func burn_torch():
	turns_remaining -= 1
	if turns_remaining == 0:
		consume_item()
	else:
		update_description()

func update_description():
	description = "Serves as a light source. %i rooms remaining." % turns_remaining
