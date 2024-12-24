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

## Magic Resistance
Magic resistance is considered an attribute by the source book, but it functions as a skill with checks and such. Thusly it is implemented as a skill.

# Implementation
The individual attributes are subnodes under $Character/%Attributes. %Attributes is an organizational to route calls to the attributes via the form Character.attributes.attribute_name

Each attribute watches for signals relating to events or actions and updates itself, then sending a signal about the new status.

## Access
Each attribute has details() that will return the details dictionary, and change(amount) that will modify the attribute.
