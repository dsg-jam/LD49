extends Control


var progress_bars = {}

onready var option_container := $VBoxContainer/StatProgressBars

func _ready():
	get_stats()
	var err := Manager.connect("value_changed", self, "_on_value_changed")
	assert(err == OK)

func get_stats():
	for child in option_container.get_children():
		progress_bars[child.name.to_lower()] = child

func _on_value_changed(name: String, value: int):
	progress_bars[name].value = value
