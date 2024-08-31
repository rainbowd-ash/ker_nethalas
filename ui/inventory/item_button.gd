extends Button
class_name ItemButton

signal item_button_pressed(item : Item)

var item : Item

func _init(a_item : Item) -> void:
	item = a_item

func _ready() -> void:
	text = item.title
	toggle_mode = true
	pressed.connect(_on_pressed)

func _on_pressed():
	item_button_pressed.emit(item)
