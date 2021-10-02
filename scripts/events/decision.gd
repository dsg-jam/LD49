class_name Decision
extends LGameEvent

const Option := preload("res://scripts/events/decision_option.gd")

var options: Array

func execute_consequence() -> void:
	# TODO implement using state
	pass

func from_dict(data: Dictionary) -> void:
	.from_dict(data)

	self.options = []
	for option in data["options"]:
		var opt := Option.new()
		opt.from_dict(option)
		self.options.append(opt)
