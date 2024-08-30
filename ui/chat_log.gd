extends RichTextLabel

func _ready() -> void:
	SignalBus.chat_log.connect(add_line)

func add_line(new_text : String):
	append_text(new_text + "\n")
