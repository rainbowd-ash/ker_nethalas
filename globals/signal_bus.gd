extends Node
# class_name SignalBus

# emitted when something needs the chatlog to add a line
signal chat_log(new_string : String)

# emitted when item picked up off floor
signal item_picked_up(item : Item)
# emitted by inventory when item dropped
signal item_dropped(item : Item)
signal item_equipped(equipment : Equipment)
signal item_dequipped(equipment : Equipment)

# emitted when player moves into a room
signal moved_through_door()
# emitted after combat/event/light checks
signal new_room_rolls_finished()
# emitted when backtracking
signal room_reentered()

signal mode_transition(new_mode_name : String)
signal combat_finished()

signal attack(values : Attack)
signal monster_picked(monster : Monster)
signal part_picked(part : BodyPart)

# emitted by something that wants to force the equipped lightsource to diminish
	# take a break
	# some growing darkness table events
signal burn_light(amount : int)
