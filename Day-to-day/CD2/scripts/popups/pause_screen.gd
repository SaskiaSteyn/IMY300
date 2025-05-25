extends Control

func _unhandled_input(event) -> void:
	if event is InputEventKey:
		if(event.pressed and event.keycode == KEY_ESCAPE):
			await get_tree().create_timer(0.1).timeout
			Global.is_paused = false
			queue_free()

func _on_resume_pressed() -> void:
	Global.is_paused = false
	Global.in_clickable = false
	Global.dismiss_popup.emit()
	queue_free()


func _on_quit_pressed() -> void:
	get_tree().quit()
