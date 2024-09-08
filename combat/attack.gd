class_name Attack

var source : Node
var target : Node
var damage : Damage
var location : BodyPart = null
var disabling_strike : bool = false

func _init(a_source : Node = null, a_target : Node = null, a_damage : Damage = null) -> void:
	source = a_source
	target = a_target
	damage = a_damage
