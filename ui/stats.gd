extends GridContainer

func _ready() -> void:
	call_deferred("update_stats")
	Character.attributes.health.health_changed.connect(update_stats)

func update_stats() -> void:
	var health = Character.attributes.health.details()
	var sanity = Character.attributes.sanity.details()
	var toughness = Character.attributes.toughness.details()
	var exhaustion = Character.attributes.exhaustion.details()
	$Health.text = "health: %d / %d" % [health.current_health, health.max_health]
	$Sanity.text = "sanity: %d / %d" % [sanity.current_sanity, sanity.max_sanity]
	$Toughness.text = "toughness: %d / %d" % [toughness.current_toughness, toughness.max_toughness]
	#$Exhaustion.text = "exhaustion: %d" % [Character.attributes.exhaustion]
	#$Aether.text = "aether: %d / %d" % [Character.attributes.aether, Character.attributes.max_aether]
	#$MagicResistance.text = "magic resist: %d" % [Character.attributes.magic_resistance]
