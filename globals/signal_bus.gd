extends Node
# class_name SignalBus

# emitted when item picked up off floor
signal item_picked_up(item : Item)
# emitted when player moves into a room
signal moved_through_door()

signal mode_transition(new_mode_name : String)


signal monster_attack(values : Dictionary)
