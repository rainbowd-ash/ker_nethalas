 # Camping
The process of taking a long rest.

## Process
1. Decide to set camp
2. Pick camp activites
3. Camp check
4. Apply benefits of camping (ration consumed at this step)
5. Move on

## Camp Check
Roll a d20 and apply modifiers to result. A 10+ is a success, otherwise it is a failure and the benefits of camping are reduced by half.

## Benefits of Camping
On a failed camp check, these benefits are reduced by 1/2.

Full benefits require 1 ration consumed, otherwise benefits are reduced by 1/2.

* Regain all toughness
* Regain 1 health
* Regain d4 sanity
* Reduce exhaustion by 10

## Camp Activities
### Attune
Spend an attunement crystal to attune one magic item. Repeatable.
* 1 exhaustion per item

### Barricade
Spend 1 crafting supplies to reinforce camp. Repeatable.
* 1 exhaustion
* +5 to camp check

### Cook
Tun N cooking ingredients into N rations. Effects only apply once.
* 1 exhaustion
* -1 to camp check

### Craft bandages
Tun N crafting supplies into N bandages. Effects only apply once.
* 1 exhaustion
* -1 to camp check

### Craft lamp oil
Turn 2N crafting supplies into N lamp oil. Effects only apply once.
* 1 exhaustion
* -2 to camp check

### Craft ritual ingredients (Ritualist mastery only)
Turn 5N crafting supplies into N ritual ingredients. Effects only apply once.
* 1 exhaustion
* -2 to camp check

### Craft torches
Tun N crafting supplies into N torches. Effects only apply once.
* 1 exhaustion
* -2 to camp check

### Heal status condition
Spend 1 bandage to remove 1 condition.
* 1 exhaustion

### Repair gear
Spend 2 crafting supplies to repair a single piece of gear. Effects only apply once.
* 2 exhaustion
* -2 to camp check

### Rest
Take no other actions from this list.
* reduce exhaustion by 5
* regain 1 health
* -2 to camp check

### Swap mastery amulets
Swap masteries. No cost.

# Execution
Camping will be on a seperate screen, overlaid on top of the dungeon view.

No undo on actions, no confirmation on buttons.

## UI Elements
3 panel layout: action buttons, info panel, list of camp stats.

### Action buttons
There will be a bunch of buttons with the activity names. Mouseover/focus on the activities to show the details and effects in dedicated info panel.

Repeatable actions do not need a picker for repeat actions. Simply click the button multiple times.

### Info panel
Shows context info.

Shows detailed information of focused action button.

Shows gear stats when selecting repair action and picking item.

Once a "effects only apply once" action has been taken, grey out the costs to indicate that they won't apply again.

### Camp stats
* "Camp score" starting at 10 and going up and down as actions are taken
* Sum of all camp effects (camp bonus + action effects)
* Inventory button?
