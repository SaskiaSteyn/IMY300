extends Node2D
class_name ClickableCore

func _ready() -> void:
	Global.clickable_clicked.connect(_is_game_done.bind())
	
func _is_game_done() -> void:
	var clickables:  = get_tree().get_nodes_in_group("clickables")
	for clickable: Clickable in clickables:
		if !clickable.is_clicked :
			return
	
	await get_tree().create_timer(1).timeout
	Global.clickable_chore_completed.emit()
	Global.dismiss_popup.emit()
	Global.in_clickable = false
	queue_free()
