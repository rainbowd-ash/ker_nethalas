extends Node
# class_name SignalBus

# emitted when something needs the chatlog to add a line
signal chat_log(new_string : String)

# emitted when item picked up off floor
signal item_picked_up(item : Item)
# emitted by inventory when item dropped
signal item_dropped(item : Item)
# emitted when player moves into a room
signal moved_through_door()

signal mode_transition(new_mode_name : String)

signal monster_attack(values : Dictionary)
