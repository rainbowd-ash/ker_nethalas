extends Node
#class_name AccusedTable

func roll():
	return accused_table[randi_range(1, accused_table.size())]

const accused_table = [
	"highway robbery",
	"witchcraft",
	"poaching",
	"smuggling",
	"piracy",
	"murder",
	"sedition",
	"treason",
	"counterfeiting",
	"housebreaking",
	"vagrancy",
	"dueling",
	"rioting",
	"blasphemy",
	"grave robbery",
	"fraud",
	"trespassing",
	"clandestine marriage",
	"child theft",
	"sodomy" # O.O
]
