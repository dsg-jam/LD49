extends Control

export var option_prefab: PackedScene

onready var event_database := get_node("/root/EventDatabase")
onready var option_container := $HBoxContainer

func _ready() -> void:
	self.render(event_database._decisions[1])

func render(decision: LGameDecision) -> void:
	for option in decision.options:
		var node := option_prefab.instance()
		option_container.add_child(node)
		node.setup(option)
		var err := node.connect("pressed", self, "_on_option_pressed", [option])
		assert(err == OK)

func _on_option_pressed(option: LGameDecision.Option) -> void:
	print("pressed", option)
