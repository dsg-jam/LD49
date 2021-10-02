extends Node

const RAW_DECISIONS := [
	{
		"gid": 1,
		"name": "Test",
		"options": [
			{
				"text": "Let's just literally kill everyone",
				"consequences": {
					"military": 20,
					"stability": -10
				}
			},
			{
				"text": "Figure it out yourselves",
				"consequences": {
					"military": -20,
					"stability": 10
				}
			},
			{
				"text": "...",
				"consequences": {
					"money": 5
				}
			}
		]
	}
]

# gid -> LGameDecision
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
