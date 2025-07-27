extends ColorRect

var unlocked_room_count: float = 0.0

func _ready() -> void:
	Global.unlock_room.connect(_change_saturation.bind())
	#Global.trigger_popup.connect(_draw_on_top.bind())
	#Global.dismiss_popup.connect(_draw_at_regular_pos.bind())
	var value: float = (Global.Rooms.size() - unlocked_room_count)/Global.Rooms.size()
	color = Color(1, 1, 1, value)
	
	
func _change_saturation(unlock_room: Global.Rooms) -> void:
	print("change saturation triggered")
	unlocked_room_count += 1
	var value: float = (Global.Rooms.size() - unlocked_room_count)/Global.Rooms.size()
	var tween = get_tree().create_tween()
	tween.tween_property(self, "color", Color(1,1,1,value), 3).set_trans(Tween.TRANS_SINE)
			#tween.tween_property(sprite, "rotation_degrees", 0, 1).set_trans(Tween.TRANS_SINE)
			#tween.tween_callback(_make_bed)
	#color = Color(1, 1, 1, value)

func _draw_on_top(popup: Node) -> void:
	print("drawing on top")
	top_level = true

func _draw_at_regular_pos() -> void:
	print("drawing at regular pos")
	top_level = false
