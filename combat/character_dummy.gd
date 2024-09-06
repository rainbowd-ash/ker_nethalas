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
		if get_parent().get_monsters().size() > 1:
			get_parent().monster_picker()
			var target = await SignalBus.monster_picked
			standard_attack(target)
		else:
			standard_attack(get_parent().get_monsters()[0])
	elif action_key == "flee":
		flee()

func list_player_actions():
	Router.actions_ui.list_actions([
		Action.new(self,"standard attack"),
		Action.new(self,"flee")
	])

func standard_attack(target : Monster):
	var weapons : Array = Character.gear.get_weapons()
	if weapons == []:
		weapons.push_back(Character.get_unarmed_weapon())
	for weapon in weapons:
		var attack_skill = Character.skills.get_value(
			Character.skills.all_skills.keys()[weapon.skill]
		) + Character.gear.modify_skill("attack")
		var roll = Dice.opposed_check(
			CheckValue.new(attack_skill),
			CheckValue.new(target.get_combat_skill())
		)
		if roll.winner == Dice.opposed_winner.attacker:
			var attack = CombatAttack.new(self,target)
			attack.damage = Damage.new(
				Dice.to_damage(weapon.die),
				weapon.damage_type
			)
			SignalBus.chat_log.emit("%s attack hits!" % weapon.title)
			SignalBus.combat_attack.emit(attack)
		# do monster roll on defensive move table if needed
		else:
			SignalBus.chat_log.emit("%s attack misses!" % weapon.title)
	get_parent().player_round_finished.emit()

func flee():
	# TODO: actually do the flee check
	# TODO: give player choice of door to run through
	# TODO: keep track of monster in room (room monster_defeated bool)
	SignalBus.chat_log.emit("You get away safely")
	get_parent().in_combat = false
	get_parent().player_round_finished.emit()

func get_defence_skill() -> int:
	# TODO fix these so they make more sense (ask character.skills for modified skill value and that checks everywhere)
	var value = Character.skills.get_value("dodge")
	value += Character.gear.modify_skill("defence")
	return value

func get_initiative_value() -> int:
	var value = Character.skills.get_value("perception")
	value += initiative_mod
	value += Character.gear.modify_skill("initiative")
	return value

# checks weapons for attack rolls and modifiers (speed etc)
# returns Damage (after table conversion)
func get_standard_attack_damage(weapon : Weapon) -> Damage:
	return 

func _on_combat_attack(attack):
	if attack.target == self:
		Character.attributes.health -= attack.damage.amount
		
		Character.attributes.attributes_changed.emit()
