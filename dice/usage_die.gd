class_name UsageDie

# roll the die when specified,
	# on a roll of 1-2, lower the size by 1
	# if a 1-2 is rolled on the d4, trigger event

const size_chain = [
	"d4",
	"d6",
	"d8",
	"d10",
	"d12",
	"d20",
]

var base_size : int # index on size chain of start position (3 = d10) -- die will reset to this size after triggering
var current_size : int # index on size chain of current position

func _init(a_base_size : int) -> void:
	base_size = a_base_size
	current_size = base_size

# roll die. returns true if triggered and size reset otherwise false
func roll() -> bool:
	var roll_result = Dice.roll(1, size_chain[current_size])
	if roll_result == 1 or roll_result == 2:
		if current_size == 0:
			current_size = base_size
			return true
		else:
			current_size -= 1
			return false
	else:
		return false
