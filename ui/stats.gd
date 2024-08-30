extends GridContainer



func _ready() -> void:
	call_deferred("update_stats")
	
	Character.attributes.attributes_changed.connect(update_stats)

func update_stats() -> void:
	$Health.text = "health: %d / %d" % [Character.attributes.health, Character.attributes.max_health]
	$Sanity.text = "sanity: %d" % [Character.attributes.sanity]
	$Toughness.text = "toughness: %d" % [Character.attributes.toughness]
	$Aether.text = "aether: %d / %d" % [Character.attributes.aether, Character.attributes.max_aether]
	$MagicResistance.text = "magic resist: %d" % [Character.attributes.magic_resistance]
	$Exhaustion.text = "exhaustion: %d" % [Character.attributes.exhaustion]
