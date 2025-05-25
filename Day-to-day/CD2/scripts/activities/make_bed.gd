extends Activity

@onready var making_bed = preload("res://assets/sfx/making bed_mixdown.wav")
@onready var making_bed_game = preload("res://scenes/clickables/make_bed.tscn")

func _init():
	super(gain_fun, loss_fun)
	clickable_finished_func = clickable_game_completed
	clickable_game = load("res://scenes/clickables/make_bed.tscn")
	
	energy_streak_map = {
		0: -4,
		1: -4,
		2: -4,
		3: -4,
		4: -3
	}
	
	unlockables_map = {
		0: unlockable_func_day_zero
	}

var gain_fun = func(x):
	print(x)
	
var loss_fun = func(x):
	print(x)

var unlockable_func_day_zero = func(): 
	var key_scene = load("res://scenes/key.tscn").instantiate()
	Global.curr_room.add_child(key_scene)
	
var clickable_game_completed = func():
	print("clickable_game_completed")
	AudioPlayer.playOnce(making_bed)
	_make_bed()
	was_done_today = true

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_player_in_room and !Global.is_walking and !was_done_today and is_activity_doable and !Global.in_clickable):
			Global.mouse_click()
			is_playing_clickable_chore = true
			var clickable_game_node = clickable_game.instantiate()
			Global.trigger_popup.emit(clickable_game_node)
			
			
func _make_bed() -> void:
	#var made_bed = load("res://assets/art/bed-sprite.png")
	#sprite.texture = made_bed
	Global.activity_done.emit(self)
	Global.making_bed.emit(true)
