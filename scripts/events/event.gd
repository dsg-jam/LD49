class_name LGameEvent

var gid: int
var name: String

func execute_consequence(_manager) -> void:
	push_error("event without consequence implementation")

func from_dict(data: Dictionary) -> void:
	self.gid = data["gid"] as int
	self.name = data["name"] as String
