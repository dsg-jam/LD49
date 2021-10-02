extends Control


var progress_bars = {}

onready var option_container := $HBoxContainer

func _ready():
	get_stats()
	Manager.connect("value_changed", self, "_on_value_changed")

func get_stats():
	for child in option_container.get_children():
		progress_bars[child.name.to_lower()] = child
	print(progress_bars)

func _on_value_changed(name: String, value: int):
	print(name)
	progress_bars[name].value = value
