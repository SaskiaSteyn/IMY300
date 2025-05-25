extends Activity


@onready var sleeping_sound = preload("res://assets/sfx/making bed_mixdown.wav")



func _init():
	super(gain_fun, loss_fun)
	energy_streak_map = {
		0: 5,
		1: 1,
		2: 1,
		3: 1,
		4: 1
	}
	
	#events_map = {
		#0:  progress_day
	#}
	
	constant_func = progress_day

var gain_fun = func(x):
	print(x)
	
var loss_fun = func(x):
	print(x)
	
var progress_day = func(): 
	#aGlobal.change_energy.emit(5)
	Global.progress_day.emit()


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_player_in_room and !Global.is_walking and !was_done_today and is_activity_doable and !Global.in_clickable):
			Global.mouse_click()
			AudioPlayer.playOnce(sleeping_sound)
			#var tween = get_tree().create_tween()
			#tween.tween_property(sprite, "rotation_degrees", 360, 1).set_trans(Tween.TRANS_SINE)
			#tween.tween_property(sprite, "rotation_degrees", 0, 1).set_trans(Tween.TRANS_SINE)
			#tween.tween_callback(_make_bed)
			_make_bed()
			was_done_today = true
			
			
func _make_bed() -> void:
	sprite.rotation_degrees = 0
	Global.activity_done.emit(self)
