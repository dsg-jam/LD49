class_name LGameDecision
extends LGameEvent

class Option:
	var text: String
	var consequences: Dictionary

	func from_dict(data: Dictionary) -> void:
		self.text = data["text"] as String
		self.consequences = data["consequences"]
		for stat in self.consequences:
			assert(stat is String)
			assert(self.consequences[stat] is int)

var options: Array
var chosen_option: int

func execute_consequence(manager: Manager) -> void:
	var chosen_option: Option = self.options[self.chosen_option]
	for stat in chosen_option.consequences:
		manager.stats[stat].change_value(chosen_option.consequences[stat])

func from_dict(data: Dictionary) -> void:
	.from_dict(data)

	self.options = []
	for option in data["options"]:
		var opt := Option.new()
		opt.from_dict(option)
		self.options.append(opt)
