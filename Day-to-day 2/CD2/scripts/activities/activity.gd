extends StaticBody2D
class_name Activity

@export var current_streak: int = 0
@export var was_done_today: bool = false

@export var energy_streak_map = {}
@export var rewards_map = {}
@export var unlockables_map = {}

var gain_func
var loss_func

var is_activity_doable: bool = false

func _init(gf, lf):
	gain_func = gf
	loss_func = lf
	
	
func _ready() -> void:
	Global.energy_bar_value_changed.connect(_is_activity_doable.bind())
	Global.pong_energy_bar.connect(_is_activity_doable.bind())
	Global.ping_energy_bar.emit()
	
func _is_activity_doable(value: float) -> void:
	if(value >= abs(energy_streak_map[current_streak])):
		is_activity_doable = true
	else:
		is_activity_doable = false
