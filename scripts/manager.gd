extends Node

signal value_changed
signal decision_started(decision)
signal day_changed(day)

# String -> int
var stats := {
	"military": 50,
	"stability": 50,
	"money": 50,
	"diplomacy": 50
}
# LGameEvent[]
var event_logs := []
var cause_of_death: String
var _day_index: int
var _event_index: int


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

func check_requirements(decision: LGameDecision) -> bool:
	for requirement in decision.requirements:
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
	self._day_index = 0
	emit_signal("day_changed", self._day_index)

	self._event_index = -1
	self.next_round()

func run_event(event: LGameEvent) -> void:
	event.execute_consequence(self)
	self.create_log(event)

func next_round() -> void:
	var gid: int
	# find next event gid that has its requirements matched
	while true:
		self._event_index += 1
		if self._event_index >= EventDatabase.EVENT_ORDER.size():
			# TODO end of game
			assert(false, "ran out of events")

		gid = EventDatabase.EVENT_ORDER[self._event_index]
		if self.check_requirements(EventDatabase.get_decision_from_gid(gid)):
			break
	emit_signal("decision_started", gid)

func finish_decision(decision: LGameDecision) -> void:
	self.run_event(decision)
	self.next_round()
