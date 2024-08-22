extends Control
class_name RoomSelector

@onready var dungeon = get_node("/root/Game/Dungeon")
@onready var room_button = load("res://modes/dungeon/room_button.tscn")

func update_selector():
	for child in $VBoxContainer.get_children():
		child.queue_free()
	for door in dungeon.get_doors():
		var button = room_button.instantiate()
		button.door_selected.connect(_on_button_door_selected)
		button.set_text(door.name)
		button.door = door
		$VBoxContainer.add_child(button)
		button.grab_focus()

func _on_dungeon_moved_through_door():
	update_selector()

func _on_button_door_selected(door : Door):
	dungeon.move_through_door(door)

func _on_timer_timeout():
	update_selector()
