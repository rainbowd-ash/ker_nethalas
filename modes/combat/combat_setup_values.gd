class_name CombatSetupValues

var monster : Monster = null
var player_surprised : bool = false
var monster_surprised : bool = false

func _init(a_monster : Monster, 
			a_player_surprised : bool = false, 
			a_monster_surprised : bool = false) -> void:
	monster = a_monster
	player_surprised = a_player_surprised
	monster_surprised = a_monster_surprised
	
