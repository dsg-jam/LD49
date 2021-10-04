extends Control

func _on_TextureButton_pressed():
	var err := get_tree().change_scene("res://scenes/overview.tscn")
	assert(err == OK)
	Manager.restart()
