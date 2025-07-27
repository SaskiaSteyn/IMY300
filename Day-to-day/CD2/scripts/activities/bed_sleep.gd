extends Activity


@onready var sleeping_sound = preload("res://assets/sfx/making bed_mixdown.wav")

@onready var default_texture = load("res://assets/art/bed-sprite.png")
@onready var sleeping_in_bed = load("res://assets/art/bedroom/Sleeping_In_Bed.png")


func _init():
	super(gain_fun, loss_fun)
	input_func = input_func_event
	energy_streak_map = {
		0: 3,
		1: 3,
		2: 3,
		3: 3,
		4: 3
	}
	
	#events_map = {
		#0:  progress_day
	#}
	
	constant_func = progress_day
	reset_func = custom_reset_func

var gain_fun = func(x):
	print(x)
	
var loss_fun = func(x):
	print(x)
	
var progress_day = func(): 
	#aGlobal.change_energy.emit(5)
	Global.progress_day.emit()
	
var input_func_event = func():
	AudioPlayer.playOnce(sleeping_sound)
	_go_to_sleep()
	was_done_today = true
	
var custom_reset_func = func():
	sprite.texture = default_texture

#func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	#if event is InputEventMouseButton:
		#if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_player_in_room and !Global.is_walking and !was_done_today and is_activity_doable and !Global.in_clickable):
			#Global.mouse_click()
			
			
			
func _go_to_sleep() -> void:
	sprite.texture = sleeping_in_bed
	Global.activity_done.emit(self)
	Global.is_sleeping.emit(true)
