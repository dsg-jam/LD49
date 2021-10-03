class_name LGameEvent

class Requirement:
	var gid: int
	var chosen_option_id: String

	# String -> int (stat -> absolute value)
	var min_stats: Dictionary
	# String -> int (stat -> absolute value)
	var max_stats: Dictionary

	func matches(event: LGameEvent, stats: Dictionary) -> bool:
		if self.gid != -1 && self.gid != event.gid:
			return false
		if self.chosen_option_id:
			if event.has_method("get_chosen_option") and self.chosen_option_id != event.get_chosen_option().id:
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
			self.chosen_option_id = data["chosen_option_id"] as String
		else:
			self.gid = -1
			self.chosen_option_id = ""

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

var gid: int
var name: String

# Requirement[]
var requirements: Array

func execute_consequence(_manager) -> void:
	push_error("event without consequence implementation")

func from_dict(data: Dictionary) -> void:
	self.gid = data["gid"] as int
	self.name = data["name"] as String
	
	self.requirements = []
	if "requirements" in data:
		for raw_requirement in data["requirements"]:
			var requirement := Requirement.new()
			requirement.from_dict(raw_requirement)
			self.requirements.append(requirement)
