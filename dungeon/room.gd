extends Sprite2D
class_name Room

var scavenged = false
var visited = false

func _ready() -> void:
	SignalBus.item_dropped.connect(add_item)
	add_item(Backpack.new())
	add_item(LightHelmet.new())
	add_item(GreatAxe.new())

func add_item(item : Item) -> void:
	add_child(item)

func get_doors() -> Array:
	var return_array = []
	for child in get_children():
		if child is Door:
			return_array.push_back(child)
	return return_array

func get_attached_doors() -> Array:
	var return_array = []
	for child in get_children():
		if child is Door:
			# MAJOR ASSUMPTION ALERT
			# A DOOR WILL ONLY EVER COLIDE WITH ONE OTHER DOOR????
			return_array.push_back(child.get_paired_door())
	return return_array # array of Door nodes

func get_items() -> Array:
	var items = []
	for child in get_children():
		if child is Item:
			items.push_back(child)
	return items

func remove_item(item : Item) -> Item:
	var removed = null
	for child in get_children():
		if child == item:
			removed = item
			remove_child(item)
	return removed

func get_actions() -> Array:
	return [
		Action.new(self, "scavenge","scavenge",(true if not scavenged else false)),
		Action.new(self, "doors"),
	]

func do_action(action_key : String):
	if action_key == "scavenge":
		scavenge()
		get_parent().list_actions()
		return
	elif action_key == "doors":
		var door_actions = []
		var counter : int = 1
		for door in get_attached_doors():
			door_actions.push_back(Action.new(door, "move", "move through door %d" % counter))
			counter += 1
		Router.actions_ui.list_actions(door_actions)
		return
	elif action_key == "pick up":
		var items = get_items()
		if items:
			remove_child(items[0])
			Character.inventory.add_item(items[0])
			SignalBus.chat_log.emit("picked up %s" % items[0].title)
			remove_item(items[0])
		else:
			print("picked up nothing (>_<)")
		get_parent().list_actions()

# can scavenge once per room
# make a scavenge check
	# on success, go through scavenge table below
	# on crit success, add 5 to d20 roll and go through scavenge table below
	# on fail, roll combat encounter
func scavenge():
	SignalBus.chat_log.emit("you rifle through bones and spiderwebs to find anything useful.")
	scavenged = true
	var scavenge_check = Dice.check(CheckValue.new(Character.skills.get_value("scavenge")))
	if scavenge_check.success:
		var scavenge_roll = Dice.roll("1d20")
		print("\tscavenge table roll: %d" % scavenge_roll)
		if scavenge_check.critical:
			scavenge_roll += 5
			if scavenge_roll > 20:
				scavenge_roll = 20
				print("\ttable roll + 5: %d" % scavenge_roll)
		if scavenge_roll == 1:
			# You uncover some grisly remains. Make a successful Resolve check or lose 1 Sanity
			Dice.check(CheckValue.new(Character.skills.get_value("resolve")))
		elif scavenge_roll == 2:
			# you find nothing of interest
			pass
		elif scavenge_roll == 3:
			# you discover d20c
			Character.inventory.adjust_currency(Dice.roll("1d20"))
		elif scavenge_roll >= 4 and scavenge_roll <= 11:
			# you find d4 crafting supplies
			Character.inventory.add_item(CraftingSupplies.new(Dice.roll("1d4")))
		elif scavenge_roll == 12:
			# you discover 2d20c
			Character.inventory.adjust_currency(Dice.roll("2d20"))
		elif scavenge_roll >= 13 and scavenge_roll <= 18:
			# you find d4 cooking supplies
			Character.inventory.add_item(CookingSupplies.new(Dice.roll("1d4")))
		elif scavenge_roll == 19:
			# you discover d100c
			Character.inventory.adjust_currency(Dice.roll_100(0).roll)
		elif scavenge_roll == 20:
			# roll on the spoils table
			# TODO add the spoils table
			pass
	find_parent("Dungeon").list_actions()
	if not scavenge_check.success:
		# roll a combat encounter
		SignalBus.chat_log.emit("your loud, pathetic attempts to scavenge have attracted a monster!")

