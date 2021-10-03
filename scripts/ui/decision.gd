extends Control

signal selected(event)

export var option_prefab: PackedScene

var _decision: LGameDecision

onready var option_container := $HBoxContainer
onready var panel := $TextureRect
onready var label := $TextureRect/Label

func setup(decision: LGameDecision) -> void:
	panel.rect_size.y = label.rect_size.y + 20
	self._decision = decision

	label.text = decision.prompt

	panel.rect_size.y = label.get_line_count() * label.get_line_height() * 2

	for child in option_container.get_children():
		option_container.remove_child(child)
		child.queue_free()

	for i in range(decision.options.size()):
		var option: LGameDecision.Option = decision.options[i]
		var node := option_prefab.instance()
		option_container.add_child(node)
		node.setup(option)
		var err := node.connect("pressed", self, "_on_option_pressed", [i, option])
		assert(err == OK)

	self.visible = true

func _on_option_pressed(index: int, _option: LGameDecision.Option) -> void:
	self._decision.chosen_option = index
	emit_signal("selected", self._decision)

