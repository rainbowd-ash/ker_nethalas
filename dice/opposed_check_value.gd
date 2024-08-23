class_name OpposedCheckResult

var winner = Dice.opposed_winner.attacker
var attacker_success : bool = false
var defender_success : bool = false
var attacker_critical : bool = false
var defender_critical : bool = false

func _init(attacker_checkvalue : CheckResult = null, defender_checkvalue : CheckResult = null):
	if attacker_checkvalue:
		attacker_success = attacker_checkvalue.success
		attacker_critical = attacker_checkvalue.critical
	if defender_checkvalue:
		defender_success = defender_checkvalue.success
		defender_critical = defender_checkvalue.critical
