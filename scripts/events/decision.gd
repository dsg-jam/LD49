class_name LGameDecision
extends LGameEvent

class Option:
	var text: String
	# String -> int (stat -> change)
	var consequences: Dictionary

	func from_dict(data: Dictionary) -> void:
		self.text = data["text"] as String
		self.consequences = data["consequences"]
		for stat in self.consequences:
			assert(stat is String)
			assert(self.consequences[stat] is int)

var prompt: String
# Option[]
var options: Array
var chosen_option: int

func execute_consequence(manager) -> void:
	var option: Option = self.options[self.chosen_option]
	for stat in option.consequences:
		manager.change_stat(stat, option.consequences[stat])

func from_dict(data: Dictionary) -> void:
	.from_dict(data)

	self.prompt = data["prompt"]
	self.options = []
	for option in data["options"]:
		var opt := Option.new()
		opt.from_dict(option)
		self.options.append(opt)
