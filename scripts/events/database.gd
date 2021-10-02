extends Node

const RAW_DECISIONS := [
	{
		"gid": 1,
		"name": "Test",
		"options": [
			{
				"text": "Option 1",
				"consequences": {
					"military": -10
				}
			}
		]
	}
]

var _decisions: Dictionary

func _init() -> void:
	self._parse_decisions(RAW_DECISIONS)

func _parse_decisions(data: Array) -> void:
	self._decisions = {}

	for raw in data:
		var decision := LGameDecision.new()
		decision.from_dict(raw)
		assert(!decision.gid in self._decisions)

		self._decisions[decision.gid] = decision
