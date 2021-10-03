extends Node

onready var event_display := $Event
onready var decision_display := $Decision
onready var day_label := $Day

func _ready() -> void:
	var err := Manager.connect("decision_started", self, "_on_decision_started")
	assert(err == OK)
	err = Manager.connect("eod_event_started", self, "_on_eod_event_started")
	assert(err == OK)
	err = Manager.connect("day_changed", self, "_on_day_changed")
	assert(err == OK)

	event_display.visible = false
	decision_display.visible = false
	Manager.start_game()

func _on_day_changed(day: int) -> void:
	day_label.text = "DAY %d" % (day + 1)

func _on_decision_started(p_decision: LGameDecision) -> void:
	decision_display.setup(p_decision)

func _on_Decision_selected(p_decision: LGameDecision) -> void:
	decision_display.visible = false
	Manager.finish_event(p_decision)

func _on_eod_event_started(event: LGameEodEvent) -> void:
	event_display.setup(event)

func _on_Event_acknowledged(event: LGameEodEvent) -> void:
	event_display.visible = false
	Manager.finish_event(event)
