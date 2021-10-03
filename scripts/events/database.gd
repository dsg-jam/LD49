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

func get_event_from_gid(gid: int) -> LGameEvent:
	return self._events[gid] as LGameEvent

func get_day(index: int) -> LGameDay:
	return self._days[index] as LGameDay

func total_days() -> int:
	return self._days.size()

func _parse_days(data: Array) -> void:
	for raw in data:
		var day := LGameDay.new()
		day.from_dict(raw)
		self._days.append(day)

func _parse_decisions(data: Array) -> void:
	for raw in data:
		var decision := LGameDecision.new()
		decision.from_dict(raw)
		assert(!decision.gid in self._events, "gid must be unique (duplicate %d)" % decision.gid)
		self._events[decision.gid] = decision

func _parse_eod_events(data: Array) -> void:
	for raw in data:
		var event := LGameEodEvent.new()
		event.from_dict(raw)
		assert(!event.gid in self._events, "gid must be unique (duplicate %d)" % event.gid)
		self._events[event.gid] = event

func _verify() -> void:
	# negative gids are often used as special status notifications
	for gid in self._events:
		assert(gid >= 0, "gid must be positive")

	# verify that event requirements can be met (obviously not accounting for dependency loops)
	for gid in self._events:
		var event: LGameEvent = self._events[gid]
		for requirement in event.requirements:
			if requirement.gid == -1:
				continue

			var dependency: LGameEvent = self._events[requirement.gid]
			assert(dependency != null, "required gid %d not found" % requirement.gid)
			if requirement.chosen_option_id:
				assert(dependency.has_option_with_id(requirement.chosen_option_id), "required event with gid %d doesn't have the requested option %s" % [requirement.gid, requirement.chosen_option_id])

	# make sure gids referenced in day have the correct type
	for day in self._days:
		for gid in day.decision_gids:
			assert(self._events[gid] is LGameDecision, "gid %d doesn't belong to a decision event" % gid)
		for gid in day.eod_event_gids:
			assert(self._events[gid] is LGameEodEvent, "gid %d doesn't belong to a end-of-day event" % gid)

func _check_consequences(gid: int, consequences: Dictionary, stats: Dictionary) -> void:
	for stat in consequences:
		if not stat in stats:
			push_error("gid %d affects an unknown stat: %s" % [gid, stat])
		if abs(consequences[stat]) > 100:
			push_error("gid %d changes stat %s by more than 100, which is just unnecessary" % [gid, stat])

func verify_eventconsequences_with_stats(stats: Dictionary) -> void:
	for gid in self._events:
		var event: LGameEvent = self._events[gid]
		if event is LGameDecision:
			for option in event.options:
				self._check_consequences(gid, option.consequences, stats)
		elif event is LGameEodEvent:
			self._check_consequences(gid, event.consequences, stats)
