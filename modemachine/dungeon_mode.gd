extends Mode
class_name ExploreMode

func enter() -> void:
	super.enter()
	Router.dungeon.list_actions()
