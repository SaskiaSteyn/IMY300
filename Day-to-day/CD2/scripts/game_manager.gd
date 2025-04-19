extends Node

@onready var done = preload("res://assets/sfx/melancholy-ui-chime-47804.mp3")
@onready var click = preload("res://assets/sfx/select.wav")

func _ready() -> void:
	Global.activity_done.connect(_activity_done.bind())
	
func _activity_done(activity: Activity) -> void:
	AudioPlayer.playOnce(done)
	_activity_modify_energy(activity)
	
func _unhandled_input(event) -> void:
	if event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
			AudioPlayer.playOnce(click)
			
	
	
func _activity_check_day(activity: Activity) -> void:
	pass
	
func _activity_modify_energy(activity: Activity) -> void:
	Global.reduce_energy.emit(activity.energy_streak_map[activity.current_streak])

func _activity_execute_gain() -> void:
	pass

func _activity_execute_loss() -> void:
	pass

func _activity_execute_rewards() -> void:
	pass
	
func _activity_execute_unlockables() -> void:
	pass
