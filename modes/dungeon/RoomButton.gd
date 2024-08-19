extends Button
class_name RoomButton

signal door_selected(door : Door)

var door : Door

func _on_pressed():
	door_selected.emit(door)

