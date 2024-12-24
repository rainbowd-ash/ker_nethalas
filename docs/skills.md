# Skills
Skills are the characters capabilities. A skill cannot go above level 80 naturally. Temporary buffs or magic items can let skills go above 80.

The skill level is used when performing checks.

Players improve skills permanently during character creation, during skill improvement checks, and during level-up.

Note: Magic resistance is considered an attribute by the source book, but it functions as a skill with checks and such. Thusly it is implemented as a skill, but omitted from Skill Improvement or starting skill point selection.

## List of skills (starting level)
* Acrobatics (10)
* Athletics (10)
* Bladed Weapons (0)
* Bludgeoning Weapons (0)
* Dodge (10)
* Endurance (0)
* Medicine (0)
* Perception(20)
* Resolve (10)
* Reason (0)
* Scavenge (0)
* Shafted Weapons (0)
* Thievery (0)
* Fist Weapons (20)
* Magic Resistance (20)

## Skill Improvement
When the player rolls doubles during a skill check, a skill is marked for "improvement". Then, when resting at camp, roll skill improvement checks. A success increases the skill by d4, and a failure increases the skill by 1, up to the maximum of 80. Magic resistance is omitted from the list of skills that can be marked this way.

# Implementation
The Character has a subnode called %Skills. This node keeps all the individual skills as a dictionary.

## Skills Node
* %Skills is the interface through which the rest of the game accesses the skills.
* Other systems can ask this node for skill levels via skill name text string.
* When asked for a skill level, %Skills will check the relevant places for modifiers (equipment, standing events, etc) and return the current skill value.

%Skills keeps the skills as a dictionary rather than individual subnodes. I made this choice because all skills are basically just a name and a number, and it didn't seem necessary to keep them all as nodes. This could change later, but the only place it would really have an effect is inside the %Skills node, not anything accessing skill levels.

Other systems accessing skills via string name may not be the best way to go about checking skill values. It allows for errors when writing the events. %Skills does check the string it is sent and pushes an error if the name is bad.
