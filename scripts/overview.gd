extends Node

onready var decision := $Decision
onready var day_label := $Day

func _ready() -> void:
	var err := Manager.connect("decision_started", self, "_on_decision_started")
	assert(err == OK)
	err = Manager.connect("day_changed", self, "_on_day_changed")
	assert(err == OK)

	Manager.start_game()

func _on_decision_started(p_decision: LGameDecision) -> void:
	decision.setup(p_decision)
	
func _on_day_changed(day: int) -> void:
	day_label.text = "DAY %d" % (day + 1)

func _on_Decision_selected(p_decision: LGameDecision) -> void:
	decision.visible = false
	Manager.finish_decision(p_decision)
