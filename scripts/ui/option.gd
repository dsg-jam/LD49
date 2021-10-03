extends Control

onready var label := $Label

func setup(option: LGameDecision.Option) -> void:
	label.text = option.text
