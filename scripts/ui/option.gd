extends Control

export var character_portraits: Dictionary

onready var character_display := $CharacterRect
onready var label := $Label

func setup(option: LGameDecision.Option) -> void:
	label.text = option.text
	if option.character:
		character_display.texture = character_portraits[option.character]
		character_display.visible = true
	else:
		character_display.visible = false
