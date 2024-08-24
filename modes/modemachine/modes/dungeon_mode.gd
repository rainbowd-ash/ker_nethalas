extends Mode
class_name DungeonMode

func enter() -> void:
	if not attached_node:
		attached_node = attached_scene.instantiate()
		get_node("/root/Game").add_child(attached_node)
	attached_node.list_actions()

func exit() -> void:
	pass
