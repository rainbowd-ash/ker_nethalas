# Dice and Rolling
The Dice singleton.

## Rolling
A lot of the game, such as getting random loot or finding a random monster, involves rolling one or more dice and looking up the outcome from a table.

# Implementation
The game systems handle rolling on tables by calling Dice.roll() with a string describing the dice. This supports a more literal translation from the book, as events will call Dice.roll("2d6+2") and Dice parses it and returns the final number.

The Dice singleton also handles damage rolls and damage conversion to a value, as described in the combat documentation.
