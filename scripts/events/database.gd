extends Node

const DecisionsDb := preload("res://scripts/db/decisions.gd")
const EodEventsDb := preload("res://scripts/db/eod_events.gd")
const DaysDb := preload("res://scripts/db/days.gd")

# gid -> LGameEvent
var _events: Dictionary
# LGameDay[]
var _days: Array

func _init() -> void:
	self._days = []
	self._parse_days(DaysDb.RAW)
	
	self._events = {}
	self._parse_decisions(DecisionsDb.RAW)
	self._parse_eod_events(EodEventsDb.RAW)

	self._verify()

func get_decision_from_gid(gid: int) -> LGameDecision:
	return self._events[gid] as LGameDecision

func _parse_days(data: Array) -> void:
	for raw in data:
		var day := LGameDay.new()
		day.from_dict(raw)
		self._days.append(day)

func _parse_decisions(data: Array) -> void:
	for raw in data:
		var decision := LGameDecision.new()
		decision.from_dict(raw)
		assert(!decision.gid in self._events, "gid must be unique")
		self._events[decision.gid] = decision

func _parse_eod_events(data: Array) -> void:
	for raw in data:
		var event := LGameEodEvent.new()
		event.from_dict(raw)
		assert(!event.gid in self._events, "gid must be unique")
		self._events[event.gid] = event

func _verify() -> void:
	# verify that event requirements can be met (obviously not accounting for dependency loops)
	for gid in self._events:
		var event: LGameEvent = self._events[gid]
		for requirement in event.requirements:
			if requirement.gid == -1:
				continue

			var dependency: LGameEvent = self._events[requirement.gid]
			assert(dependency != null, "required gid not found")
			if requirement.chosen_option_id:
				assert(dependency.has_option_with_id(requirement.chosen_option_id), "required decision doesn't have the requested option")
