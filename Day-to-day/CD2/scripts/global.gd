extends Node

@onready var click = preload("res://assets/sfx/mixkit-mouse-click-close-1113.wav")

signal player_exit_room
signal player_enter_room
signal energy_bar_value_changed
signal change_energy
signal activity_done
signal unlock_room
signal trigger_popup
signal dismiss_popup
signal ping_energy_bar
signal pong_energy_bar
signal progress_hour
signal progress_day
signal making_bed
signal reset_day
signal clickable_chore_completed
signal clickable_clicked

var is_paused: bool = false
var in_clickable: bool = false

var unlockedRooms: float = 0.0

enum Rooms{BEDROOM, BATHROOM, KITCHEN}
enum Unlock_Room{BATHROOM, KITCHEN}
var going_to_room: Rooms

var is_walking: bool = false
var is_speeding_up_time: bool = false
var curr_room: Room

var current_time = {
	day = 1,
	hour = 06,
	minute = 00
}

func _init():
	AudioPlayer.play()

func mouse_click():
	AudioPlayer.playOnce(click)
