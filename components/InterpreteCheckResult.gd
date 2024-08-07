class_name InterpreteCheckResult
extends Node

var success = false
var critical = false

func _init(p_success : bool = false, p_critical : bool = false):
	success = p_success
	critical = p_critical
