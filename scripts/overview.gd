extends Node2D

onready var decision := $UI/Decision

func _ready() -> void:
	var err := Manager.connect("decision_started", self, "_on_decision_started")
	assert(err == OK)

	Manager.start_game()

func _on_decision_started(gid: int) -> void:
	decision.setup_with_gid(gid)

func _on_Decision_selected(p_decision: LGameDecision) -> void:
	decision.visible = false
	Manager.finish_decision(p_decision)
