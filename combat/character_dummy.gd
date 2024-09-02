extends Node
class_name CharacterDummy
# dummy stand-in for character during combat

var base_standard_action_count : int = 1
var base_free_action_count : int = 1

var standard_action_count : int = 1
var free_action_count : int = 1

var initiative : bool = true
var initiative_mod : int = 0

var surprised : bool = false
var attempting_stealth : bool = false

func _ready() -> void:
	SignalBus.combat_attack.connect(_on_combat_attack)

func reset_action_counts():
	standard_action_count = base_standard_action_count
	free_action_count = base_free_action_count

func do_action(action_key : String):
	if action_key == "standard attack":
		standard_attack()
	elif action_key == "flee":
		flee()

func list_player_actions():
	Router.actions_ui.list_actions([
		Action.new(self,"standard attack"),
		Action.new(self,"flee")
	])

func standard_attack():
	print("standard attack")
	if get_parent().get_monsters().size() > 1:
		pass # MONSTER SELECTOR
	var roll = get_parent().attack_check(self, get_parent().get_monsters()[0])
	if roll.winner == Dice.opposed_winner.attacker:
		print("successful attack")
		var attack = CombatAttack.new(self,get_parent().get_monsters()[0])
		attack.damage = get_standard_attack()
		SignalBus.chat_log.emit("Attack hits!")
		SignalBus.combat_attack.emit(attack)
	# do monster roll on defensive move table if needed
	else:
		SignalBus.chat_log.emit("Attack misses!")
	get_parent().player_round_finished.emit()

func flee():
	print("flee")
	get_parent().in_combat = false
	get_parent().player_round_finished.emit()

func get_attack_roll_value() -> int:
	return Character.skills.get_value("fist_weapons")

func get_defence_roll_value() -> int:
	return Character.skills.get_value("dodge")

func get_initiative_value() -> int:
	return Character.skills.get_value("perception") + initiative_mod

func get_standard_attack() -> Damage:
	return Damage.new(Damage.damage_types.bludgeoning,Dice.roll(1,"d6"))

func _on_combat_attack(attack):
	if attack.target == self:
		Character.attributes.health -= attack.damage.amount
		SignalBus.chat_log.emit("you take %d %s damage" % [attack.damage.amount, Damage.damage_types.keys()[attack.damage.damage_type]])
		Character.attributes.attributes_changed.emit()
