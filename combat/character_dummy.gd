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
	SignalBus.attack.connect(_on_attack)
	get_parent().player_round_finished.connect(_on_player_round_finished)

func do_action(action_key : String) -> void:
	if action_key == "standard attack":
		if get_parent().get_monsters().size() > 1:
			get_parent().monster_picker()
			var target = await SignalBus.monster_picked
			standard_attack(target)
		else:
			standard_attack(get_parent().get_monsters()[0])
	elif action_key == "flee":
		flee()

func list_player_actions() -> void:
	Router.actions_ui.list_actions([
		Action.new(self,"standard attack"),
		Action.new(self,"flee")
	])

func standard_attack(target : Monster) -> void:
	var weapons : Array = Character.gear.get_weapons()
	if weapons == []:
		weapons.push_back(Character.get_unarmed_weapon())
	for weapon in weapons:
		var roll = Dice.opposed_check(
			CheckValue.new(Character.skills.get_skill("attack")),
			CheckValue.new(target.get_skill("combat"))
		)
		if roll.winner == Dice.opposed_winner.attacker:
			var attack = Attack.new(self,target)
			attack.damage = Damage.new(
				Dice.to_damage(weapon.die),
				weapon.damage_type
			)
			SignalBus.chat_log.emit("%s attack hits!" % weapon.title)
			SignalBus.attack.emit(attack)
		# do monster roll on defensive move table if needed
		else:
			SignalBus.chat_log.emit("%s attack misses!" % weapon.title)
	get_parent().player_round_finished.emit()

func flee() -> void:
	# TODO: actually do the flee check
	# TODO: give player choice of door to run through
	# TODO: keep track of monster in room (room monster_defeated bool)
	SignalBus.chat_log.emit("You get away safely")
	get_parent().in_combat = false
	get_parent().player_round_finished.emit()

# this should call Character._on_attack() after performing whatever combat modifiers 
# monsters should call this version when attacking
func _on_attack(attack) -> void:
	if attack.target == self:
		attack.target = Character
		Character._on_attack(attack)

func _on_player_round_finished() -> void:
	# reset action counts
	standard_action_count = base_standard_action_count
	free_action_count = base_free_action_count

# skill modification methods
# ===================================================================
func modify_skill(skill : String) -> int:
	return 0
