extends StaticBody2D
class_name Activity

@export var current_streak: int = 0
@export var was_done_today: bool = false

@export var clickable_game: Resource

@export var energy_streak_map = {}
@export var events_map = {}
@export var unlockables_map = {}

@onready var sprite = $Sprite2D

var gain_func
var loss_func
#This function includes anything that needs to be executed everytime the activity is done, regardless of streak
var constant_func
var clickable_finished_func

var is_activity_doable: bool = false
var is_player_in_room: bool = false
var is_playing_clickable_chore: bool = false

func _init(gf, lf):
	gain_func = gf
	loss_func = lf
	
	
func _ready() -> void:
	Global.energy_bar_value_changed.connect(_is_activity_doable.bind())
	Global.pong_energy_bar.connect(_is_activity_doable.bind())
	Global.ping_energy_bar.emit()
	Global.clickable_chore_completed.connect(_clickable_chore_finished.bind())
	
func _is_activity_doable(value: float) -> void:
	if(value >= abs(energy_streak_map[current_streak])):
		is_activity_doable = true
	else:
		is_activity_doable = false

func reset() -> void:
	if was_done_today:
		current_streak += 1
		
	was_done_today = false
	
func _on_mouse_entered() -> void:
	if(is_player_in_room and !was_done_today):
		if(is_activity_doable):
			var material: ShaderMaterial = sprite.material
			material.set_shader_parameter("width", 10)
		else:
			var material: ShaderMaterial = sprite.material
			material.set_shader_parameter("width", 10)
			material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))


func _on_mouse_exited() -> void:
	var material: ShaderMaterial = sprite.material
	material.set_shader_parameter("width", 0)
	material.set_shader_parameter("outline_color", Color(1, 1, 1, 1))
	
func _clickable_chore_finished() -> void:
	print("_clickable_chore_finished")
	if is_playing_clickable_chore:
		is_playing_clickable_chore = false
		clickable_finished_func.call()
