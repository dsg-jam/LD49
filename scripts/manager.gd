extends Node

signal value_changed

# String -> int
var stats := {}
# LGameEvent[]
var event_logs := []
var cause_of_death


func _ready():
	stats["military"] = 50
	stats["stability"] = 50
	stats["money"] = 50
	stats["diplomacy"] = 50

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

func run_event(event: LGameEvent) -> void:
	event.execute_consequence(self)
	self.create_log(event)
