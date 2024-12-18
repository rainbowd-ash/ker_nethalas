# Attributes
Attributes are the physical status of a character. Health and toughness and such.

## Health
When this hits 0, the game is over. Starting maximum health is 1d6+8.

## Toughness
Toughness is a layer above health. When the character takes damage, toughness is reduced first. Starting maximum toughness is 2d6+10.

## Aether
Aether is used to cast spells. The starting maximum aether is 1d6+8. Aether is replenshed on entering a room. Some spells are maintained by reducing the maximum aether available while they are active.

## Sanity
Sanity is the character's mental well-being. Many events damage sanity. When it hits 0, the player rolls on the Madness table and receives a negative effect.

Whenever the character is threatened by sanity loss, they make a Resolve check. On success, they do not lose sanity. Criticals on this roll have no effect.

## Exhaustion & Exhaustion Resistance
Exhaustion works differently than the other attributes, in that it starts at 0 and goes up. Negative effects accrue as exhaustion hits breakpoints like 11+ and 16+.

The character's current Exhaustion amount is the accrued Exhaustion - Exhaustion Resistance stat.

# Implementation
* This is not how attributes are currently implemented *

The individual attributes are subnodes under $Character/%Attributes.

The rest of the game accesses the attributes through the $Character node. The Character node takes damage and handles assigning it to toughness and health, handles receiving exhaustion or sanity damage, etc.

$Character also watches for signals like "short_break" and makes the appropriate adjustments to the attributes.
