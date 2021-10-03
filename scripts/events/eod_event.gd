class_name LGameEodEvent
extends LGameEvent

var description: String
# String -> int (stat -> change)
var consequences: Dictionary

func execute_consequence(manager) -> void:
	for stat in self.consequences:
		manager.change_stat(stat, self.consequences[stat])

func from_dict(data: Dictionary) -> void:
	.from_dict(data)

	self.description = data["description"] as String
	self.consequences = data["consequences"]
	for stat in self.consequences:
		assert(stat is String)
		assert(self.consequences[stat] is int)
