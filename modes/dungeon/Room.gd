extends Sprite2D
class_name Room

var items = [Torch.new(), Backpack.new()]
var scavenged = false

func get_doors() -> Array:
	var return_array = []
	for child in get_children():
		if child is Door:
			# MAJOR ASSUMPTION ALERT
			# A DOOR WILL ONLY EVER COLIDE WITH ONE OTHER DOOR????
			return_array.push_back(child.get_paired_door())
	return return_array # array of Door nodes

func get_items():
	return items

func remove_item(item : Item):
	if items.has(item):
		items.erase(item)

func get_actions() -> Array:
	var actions = []
	if not scavenged:
		actions.push_back(Action.new(self, "scavenge"))
	if items:
		actions.push_back(Action.new(self, "pick up"))
	if not get_doors().is_empty():
		actions.push_back(Action.new(self, "doors"))
	return actions

func do_action(action_key : String):
	if action_key == "scavenge":
		scavenge()
		return
	if action_key == "doors":
		var door_actions = []
		var counter : int = 1
		for door in get_doors():
			door_actions.push_back(Action.new(door, "move", "move through door %d" % counter))
			counter += 1
		ActionSelection.list_actions(door_actions)
		return
	if action_key == "pick up":
		Character.inventory.add_item(items[0])
		remove_item(items[0])

# can scavenge once per room
# make a scavenge check
	# on success, go through scavenge table below
	# on crit success, add 5 to d20 roll and go through scavenge table below
	# on fail, roll combat encounter
func scavenge():
	print("-scavenge check-")
	scavenged = true
	var scavenge_check = Dice.check(CheckValue.new(Character.skills.get_value("scavenge")))
	if scavenge_check.success:
		var scavenge_roll = Dice.roll(1, "d20")
		print("\tscavenge table roll: %d" % scavenge_roll)
		if scavenge_check.critical:
			scavenge_roll += 5
			if scavenge_roll > 20:
				scavenge_roll = 20
				print("\ttable roll + 5: %d" % scavenge_roll)
		if scavenge_roll == 1:
			# You uncover some grisly remains. Make a successful Resolve check or lose 1 Sanity
			Dice.check(CheckValue.new(Character.get_value("resolve")))
		elif scavenge_roll == 2:
			# you find nothing of interest
			pass
		elif scavenge_roll == 3:
			# you discover d20c
			Character.inventory.adjust_currency(Dice.roll(1, "d20"))
		elif scavenge_roll >= 4 and scavenge_roll <= 11:
			# you find d4 crafting supplies
			Character.inventory.add_item(CraftingSupplies.new(Dice.roll(1, "d4")))
		elif scavenge_roll == 12:
			# you discover 2d20c
			Character.inventory.adjust_currency(Dice.roll(2, "d20"))
		elif scavenge_roll >= 13 and scavenge_roll <= 18:
			# you find d4 cooking supplies
			Character.inventory.add_item(CookingSupplies.new(Dice.roll(1, "d4")))
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
		pass

