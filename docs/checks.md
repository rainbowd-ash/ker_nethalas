# Checks
Performing actions and rolling dice to check success.

## How
When trying to do something that can fail (hit something, evade a trap, examine the artifact), roll two d10s. These are the 10s and 1s place of a number between 1 and 100. Compare this number to the level of the relevant skill. If the rolled number is equal or lower than the skill level, the attempt is a success.

## Opposed Check
When there is another party competing in this challenge (sneaking up on someone that can perceive you), then both parties roll dice and compare to their skill level.

If both parties roll the same class of outcome, such as both succeeding or both critical failing, the party with the higher skill level wins. If that does not break the tie, the aggressor wins.

## Critical Success & Failure
Rolling doubles (the same number on both die), magnifies the outcome. A regular success turns into a critical success and a failure turns into a critical failure. Critical outcomes are explicitly stated and mostly matter during combat.

## Advantage & Disadvantage
Some abilities and events will confer Advantage or Disadvantage on the next check. After rolling with advantage, if swapping the 1s and 10s die would create a better outcome (lower number), then make that swap. Disadvantage works the same way but checks for a worse outcome.

# Implementation
Checks are currently handled by the Dice singleton. They are going to be moved into their own Checks singleton, to split them off from "rolling" which is simply rolling on tables.

## Access
* This is not how access is currently implemented *

The rest of the game gets checks by calling Dice.check(int skill_level, bool advantage=false, bool disadvantage=false). This will return a dictionary with the roll value, the success boolean, and the critical boolean.
