extends Node

signal value_changed
signal decision_started(decision)
signal eod_event_started(event)
signal day_changed(day)

const INITIAL_VALUE = 50 

# String -> int
var stats := {
	"military": INITIAL_VALUE,
	"stability": INITIAL_VALUE,
	"money": INITIAL_VALUE,
	"diplomacy": INITIAL_VALUE
}
# LGameEvent[]
var event_logs := []
var cause_of_death: String

var _day_index: int
var _day: LGameDay
var _event_index: int

func _ready() -> void:
	EventDatabase.verify_eventconsequences_with_stats(stats)

func change_stat(stat: String, change: int) -> void:
	stats[stat] += change
	if stats[stat] > 100:
		stats[stat] = 100
	if stats[stat] < 0:
		stats[stat] = 0
	if stats[stat] == 0:
		# Game Over Event
		cause_of_death = stat
		var err := get_tree().change_scene("res://scenes/game_over.tscn")
		assert(err == OK)
	emit_signal("value_changed", stat, stats[stat])

func create_log(event: LGameEvent) -> void:
	event_logs.append(event)

func check_requirements(p_event: LGameEvent) -> bool:
	for requirement in p_event.requirements:
		var target_event: LGameEvent = null
		for event in self.event_logs:
			if event.gid == requirement.gid:
				target_event = event
				break
		# event not found in history
		if target_event == null:
			return false
		if !requirement.matches(target_event, stats):
			return false
	return true

func start_game() -> void:
	self._day_index = -1
	stats = {
		"military": INITIAL_VALUE,
		"stability": INITIAL_VALUE,
		"money": INITIAL_VALUE,
		"diplomacy": INITIAL_VALUE
	}
	event_logs = []
	self.next_round()

func run_event(event: LGameEvent) -> void:
	event.execute_consequence(self)
	self.create_log(event)

func game_won():
	var err := get_tree().change_scene("res://scenes/game_finished.tscn")
	assert(err == OK)

func _try_next_gid() -> int:
	# check if we should move to the next day
	if self._day_index == -1 or self._event_index >= self._day.total_event_count():
		self._day_index += 1
		if self._day_index >= EventDatabase.total_days():
			return -2

		self._day = EventDatabase.get_day(self._day_index)
		self._event_index = 0
	else:
		self._event_index += 1

	if self._event_index >= self._day.total_event_count():
		# no more events today, need to advance to next
		return -1

	var gid = self._day.get_event_gid_from_linear_index(self._event_index)
	if not self.check_requirements(EventDatabase.get_event_from_gid(gid)):
		return -1
	return gid

func next_round() -> void:
	var gid: int
	var previous_day_index := self._day_index
	# find next event gid that has its requirements matched
	while true:
		gid = self._try_next_gid()
		if gid == -1:
			continue
		if gid == -2:
			self.game_won()
			return
		# gid found
		break

	if self._day_index != previous_day_index:
		emit_signal("day_changed", self._day_index)

	var event := EventDatabase.get_event_from_gid(gid)
	if event is LGameDecision:
		emit_signal("decision_started", event)
	elif event is LGameEodEvent:
		emit_signal("eod_event_started", event)
	else:
		push_error("event with unrecognized type: %s" % event)

func finish_event(event: LGameEvent) -> void:
	self.run_event(event)
	self.next_round()
