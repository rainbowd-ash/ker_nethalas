# Signals
The game uses signals to communicate between systems.

## Usage
* Updating signals to this design pattern is an ongoing project *

All signals send a single variable with them, usually called "details". This is a dictionary with the relevant information. See the origin of the signal for the dictionary key/value pairs of each.

This is sent as a dictionary because each signal receiving function needs to enumerate all the variables from the signal, meaning adding more information to a signal would need each receiving function to update as well.

## The Signal Bus
The signal bus is an autoload called SignalBus. Different systems need to connect to signals that are "owned" by other systems. For example, many different places need to connect to the chat log to send messages. To keep the systems independent of organizational changes (chat log moves node heirarchy) the signal bus is a single place to connect up everything.
