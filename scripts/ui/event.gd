extends Control

signal acknowledged(event)

var _event: LGameEodEvent

onready var panel := $TextureRect
onready var label := $TextureRect/Label

func setup(event: LGameEodEvent) -> void:
	self._event = event

	label.text = event.description
	panel.rect_size.y = label.get_line_count() * label.get_line_height() * 2
	self.visible = true

func _on_TextureButton_pressed() -> void:
	emit_signal("acknowledged", self._event)
