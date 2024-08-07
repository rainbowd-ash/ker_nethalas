extends Node
#class_name enums

# result of opposed check
enum opposed_winner {
	attacker,
	defender,
}

# dice result of normal check
enum check_results {
	SUCCESS,
	FUMBLE,
	CRITICAL_SUCCESS,
	CRITICAL_FUMBLE,
}
