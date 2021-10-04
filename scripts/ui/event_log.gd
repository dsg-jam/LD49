extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	var err := Manager.connect("event_log_updated", self, "_update_event_log")
	assert(err == OK)

func _update_event_log(event):
		var label= Label.new()
		label.text = event.name
		label.add_color_override("font_color", Color.lightgray)
		add_child(label)
