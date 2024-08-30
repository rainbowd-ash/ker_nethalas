extends Node
#class_name Router

var game = "/root/Game/"

@onready var actions_ui = get_node(game + "Ui/Stats_Actions/Actions")
@onready var dungeon = get_node(game + "Ui/Dungeon_Chat/DungeonWindow/SubViewport/Dungeon")
