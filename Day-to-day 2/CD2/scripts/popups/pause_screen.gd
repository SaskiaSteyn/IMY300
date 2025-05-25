extends Control


func _on_resume_pressed() -> void:
	queue_free()


func _on_quit_pressed() -> void:
	get_tree().quit()
