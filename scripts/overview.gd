extends Node2D

onready var manager := get_node("/root/Manager")
onready var decision := $UI/Decision

func _ready() -> void:
	decision.visible = true
	decision.setup_with_gid(1)

func _on_Decision_selected(event: LGameEvent) -> void:
	manager.run_event(event)
	decision.visible = false
