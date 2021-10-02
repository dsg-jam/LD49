extends Node

const Stat = preload("res://scripts/stats.gd")
var stats = {}


func _ready():
	stats["military"] = Stat.new("Military")
	stats["stability"] = Stat.new("Stability")
	stats["money"] = Stat.new("Money")
	stats["diplomacy"] = Stat.new("Diplomacy")
