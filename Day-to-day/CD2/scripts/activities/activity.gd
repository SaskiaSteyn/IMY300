extends StaticBody2D
class_name Activity

@export var current_streak: int = 0
@export var was_done_today: bool = false

@export var clickable_game: Resource

@export var energy_streak_map = {}
@export var events_map = {}
@export var unlockables_map = {}

@export var is_locked: bool = true

@onready var sprite : Sprite2D = $Sprite2D
var is_locked_for_day: bool = false

var gain_func
var loss_func
#This function includes anything that needs to be executed everytime the activity is done, regardless of streak
var constant_func
var clickable_finished_func

var input_func = func():
	is_playing_clickable_chore = true
	var clickable_game_node = clickable_game.instantiate()
	Global.trigger_popup.emit(clickable_game_node)
	
var reset_func = func():
	pass

#var is_activity_doable: bool = false
var is_player_in_room: bool = false
var is_playing_clickable_chore: bool = false
var chore_queued: bool = false
var is_mouse_on_activity: bool = false


func _init(gf, lf):
	gain_func = gf
	loss_func = lf
	
	
func _ready() -> void:
	Global.energy_bar_value_changed.connect(_is_activity_doable.bind())
	Global.pong_energy_bar.connect(_is_activity_doable.bind())
	Global.ping_energy_bar.emit()
	Global.clickable_chore_completed.connect(_clickable_chore_finished.bind())
	
func _is_activity_doable() -> bool:
	if is_locked_for_day || is_locked:
		return false
		
	if(Global.actual_energy + energy_streak_map[current_streak] >= 0):
		return true
	else:
		return false

func reset() -> void:
	if was_done_today:
		current_streak += 1
		
	was_done_today = false
	is_locked_for_day = false
	reset_func.call()
	
func _on_mouse_entered() -> void:
	is_mouse_on_activity = true
	if(is_player_in_room and !was_done_today):
		if(_is_activity_doable()):
			var material: ShaderMaterial = sprite.material
			material.set_shader_parameter("width", 10)
			material.set_shader_parameter("flickering_speed", 0)
			material.set_shader_parameter("minimal_flickering_alpha", 0.9)
			Global.preview_energy_cost.emit(energy_streak_map[current_streak])
		else:
			var material: ShaderMaterial = sprite.material
			material.set_shader_parameter("width", 10)
			material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))
			material.set_shader_parameter("flickering_speed", 0)


func _on_mouse_exited() -> void:
	is_mouse_on_activity = false
	var material: ShaderMaterial = sprite.material
	material.set_shader_parameter("width", 0)
	material.set_shader_parameter("outline_color", Color(1, 1, 1, 1))
	Global.stop_energy_preview.emit()
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if (Input.is_action_just_pressed("move") and is_player_in_room and !Global.is_walking and !was_done_today and _is_activity_doable() and !Global.in_clickable):
		Global.mouse_click()
		input_func.call()
	elif (Input.is_action_just_pressed("move") and is_player_in_room and Global.is_walking and !was_done_today and _is_activity_doable() and !Global.in_clickable):
		chore_queued = true
		
	#if event is InputEventMouseButton:
		#if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_player_in_room and !Global.is_walking and !was_done_today and is_activity_doable and !Global.in_clickable):
			#Global.mouse_click()
			#input_func.call()
		#elif (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_player_in_room and Global.is_walking and !was_done_today and is_activity_doable and !Global.in_clickable):
			#chore_queued = true
	
func _clickable_chore_finished() -> void:
	if is_playing_clickable_chore:
		is_playing_clickable_chore = false
		clickable_finished_func.call()
		
func _process(delta: float) -> void:
	if chore_queued and !Global.is_walking:
		chore_queued = false
		input_func.call()
		return
	
	if !is_mouse_on_activity and is_player_in_room and !was_done_today:
		var material: ShaderMaterial = sprite.material
		material.set_shader_parameter("width", 10)
		material.set_shader_parameter("flickering_speed", 5)
		material.set_shader_parameter("minimal_flickering_alpha", 0.2)
		
