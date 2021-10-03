extends Node

const DECISIONS_DB := preload("res://scripts/events/decisions_db.gd")
const EVENT_ORDER := [1, 2, 3]

# gid -> LGameDecision
var _decisions: Dictionary

func _init() -> void:
	self._parse_decisions(DECISIONS_DB.RAW_DECISIONS)

func get_decision_from_gid(gid: int) -> LGameDecision:
	return self._decisions[gid]

func _parse_decisions(data: Array) -> void:
	self._decisions = {}

	# load decisions from dict
	for raw in data:
		var decision := LGameDecision.new()
		decision.from_dict(raw)
		assert(!decision.gid in self._decisions)
		self._decisions[decision.gid] = decision

	# verify that requirements can be met (obviously not accounting for dependency loops)
	for gid in self._decisions:
		var decision: LGameDecision = self._decisions[gid]
		for requirement in decision.requirements:
			# TODO: if support for other events is added, this needs to be adjusted to support dependencies on them
			var dependency: LGameDecision = self._decisions[requirement.gid]
			assert(dependency != null)
			if requirement.option_id:
				assert(dependency.has_option_with_id(requirement.option_id))
