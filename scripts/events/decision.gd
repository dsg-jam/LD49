class_name LGameDecision
extends LGameEvent

class Option:
	var id: String
	var text: String
	# String -> int (stat -> change)
	var consequences: Dictionary

	func from_dict(data: Dictionary) -> void:
		if "id" in data:
			self.id = data["id"] as String
		else:
			self.id = ""
		self.text = data["text"] as String
		self.consequences = data["consequences"]
		for stat in self.consequences:
			assert(stat is String)
			assert(self.consequences[stat] is int)

class Requirement:
	var gid: int
	var option_id: String

	# String -> int (stat -> absolute value)
	var min_stats: Dictionary
	# String -> int (stat -> absolute value)
	var max_stats: Dictionary

	func matches(event: LGameEvent, stats: Dictionary) -> bool:
		if self.gid != -1 && self.gid != event.gid:
			return false
		if self.option_id:
			var decision := event as LGameDecision
			if decision != null and self.option_id != decision.get_chosen_option().id:
				return false
		for stat in self.min_stats:
			if stats[stat] < self.min_stats[stat]:
				return false
		for stat in self.max_stats:
			if stats[stat] > self.max_stats[stat]:
				return false
		return true

	func from_dict(data: Dictionary) -> void:
		if "gid" in data:
			self.gid = data["gid"] as int
			self.option_id = data["option_id"] as String
		else:
			self.gid = -1
			self.option_id = ""

		if "min_stats" in data:
			self.min_stats = data["min_stats"]
			for stat in self.min_stats:
				assert(stat is String)
				assert(self.min_stats[stat] is int)
		else:
			self.min_stats = {}

		if "max_stats" in data:
			self.max_stats = data["max_stats"]
			for stat in self.max_stats:
				assert(stat is String)
				assert(self.max_stats[stat] is int)
		else:
			self.max_stats = {}

var prompt: String
# Option[]
var options: Array
# Requirement[]
var requirements: Array

var chosen_option: int = -1

func get_chosen_option() -> Option:
	assert(self.chosen_option != -1, "no option chosen yet")
	return self.options[self.chosen_option]

func has_option_with_id(id: String) -> bool:
	for option in self.options:
		if option.id == id:
			return true
	return false

func execute_consequence(manager) -> void:
	var option := self.get_chosen_option()
	for stat in option.consequences:
		manager.change_stat(stat, option.consequences[stat])

func from_dict(data: Dictionary) -> void:
	.from_dict(data)

	self.prompt = data["prompt"] as String
	self.options = []
	for option in data["options"]:
		var opt := Option.new()
		opt.from_dict(option)
		self.options.append(opt)
	assert(self.options.size() > 0, "must provide at least one option")

	self.requirements = []
	if "requirements" in data:
		for raw_requirement in data["requirements"]:
			var requirement := Requirement.new()
			requirement.from_dict(raw_requirement)
			self.requirements.append(requirement)
