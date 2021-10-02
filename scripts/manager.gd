extends Node

const Stat = preload("res://scripts/stats.gd")
const EventLog = preload("res://scripts/event_log.gd")
var stats = {}
var event_logs = []


func _ready():
	stats["military"] = Stat.new("Military")
	stats["stability"] = Stat.new("Stability")
	stats["money"] = Stat.new("Money")
	stats["diplomacy"] = Stat.new("Diplomacy")


func create_log(event: LGameEvent) -> void:
	event_logs.append(EventLog.new(event))
