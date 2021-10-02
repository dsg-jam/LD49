extends Control

signal pressed

onready var label := $Label

func setup(option: LGameDecision.Option) -> void:
	label.text = option.text

func _on_Button_pressed() -> void:
	emit_signal("pressed")
