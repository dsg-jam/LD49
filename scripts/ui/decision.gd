extends Control

signal selected(event)

export var option_prefab: PackedScene

var _decision: LGameDecision

onready var option_container := $HBoxContainer
onready var label := $Label

func setup(decision: LGameDecision) -> void:
	self._decision = decision

	label.text = decision.prompt

	for i in range(decision.options.size()):
		var option: LGameDecision.Option = decision.options[i]
		var node := option_prefab.instance()
		option_container.add_child(node)
		node.setup(option)
		var err := node.connect("pressed", self, "_on_option_pressed", [i, option])
		assert(err == OK)

func setup_with_gid(gid: int) -> void:
	self.setup(EventDatabase.get_decision_from_gid(gid))

func _on_option_pressed(index: int, _option: LGameDecision.Option) -> void:
	self._decision.chosen_option = index
	emit_signal("selected", self._decision)
