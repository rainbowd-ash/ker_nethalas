extends Mode
class_name CombatMode

func enter() -> void:
	attached_node = attached_scene.instantiate()
	get_node("/root/Game").add_child(attached_node)
	Router.combat = attached_node

func exit() -> void:
	attached_node.queue_free()
