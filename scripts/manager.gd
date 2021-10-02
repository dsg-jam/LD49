extends Node

signal value_changed
signal decision_started(decision)

# String -> int
var stats := {
	"military": 50,
	"stability": 50,
	"money": 50,
	"diplomacy": 50
}
# LGameEvent[]
var event_logs := []
var cause_of_death


func change_stat(stat: String, change: int) -> void:
	stats[stat] += change
	if stats[stat] > 100:
		stats[stat] = 100
	if stats[stat] < 0:
		stats[stat] = 0
	if stats[stat] == 0:
		# Game Over Event
		cause_of_death = stat
		get_tree().change_scene("res://scenes/game_over.tscn")
	emit_signal("value_changed", stat, stats[stat])

func create_log(event: LGameEvent) -> void:
	event_logs.append(event)

func start_game() -> void:
	self.next_round()

func run_event(event: LGameEvent) -> void:
	event.execute_consequence(self)
	self.create_log(event)

func next_round() -> void:
	emit_signal("decision_started", 2)

func finish_decision(decision: LGameDecision) -> void:
	self.run_event(decision)
	self.next_round()
