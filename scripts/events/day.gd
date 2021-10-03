class_name LGameDay

# int[]
var decision_gids: Array
# int[]
var eod_event_gids: Array

func from_dict(data: Dictionary) -> void:
	self.decision_gids = data["decisions"]
	self.eod_event_gids = data["eod_events"]
