extends Mode
class_name ExploreMode

func enter() -> void:
	super.enter()
	if Router.game_modes.get_current_mode() == "CombatMode":
		Router.combat.list_actions()
	elif Router.game_modes.get_current_mode() == "DungeonMode":
		Router.dungeon.list_actions()
