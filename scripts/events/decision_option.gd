var text: String
var consequences: Dictionary

func from_dict(data: Dictionary) -> void:
	self.text = data["text"] as String
	self.consequences = data["consequences"]
	for stat in self.consequences:
		assert(stat is String)
		assert(self.consequences[stat] is int)
