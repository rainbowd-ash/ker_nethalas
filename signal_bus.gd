extends Node
# class_name SignalBus

# emitted when item picked up off floor
signal item_picked_up(item : Item)

signal mode_transition(new_mode_name : String)

signal moved_through_door()
