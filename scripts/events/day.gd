class_name LGameDay

# int[]
var decision_gids: Array
# int[]
var eod_event_gids: Array

func total_event_count() -> int:
	return self.decision_gids.size() + self.eod_event_gids.size()

func get_event_gid_from_linear_index(index: int) -> int:
	var decisions := self.decision_gids.size()
	if index < decisions:
		return self.decision_gids[index]
	return self.eod_event_gids[index - decisions]

func from_dict(data: Dictionary) -> void:
	self.decision_gids = data["decisions"]
	self.eod_event_gids = data["eod_events"]
