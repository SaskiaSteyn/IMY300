extends Control

func _on_button_pressed() -> void:
	Global.dismiss_popup.emit()
	Global.is_paused = false
	Global.in_clickable = false
	queue_free()
