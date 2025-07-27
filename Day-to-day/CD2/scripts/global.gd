extends Node

@onready var click = preload("res://assets/sfx/mixkit-mouse-click-close-1113.wav")

signal player_exit_room
signal player_enter_room

signal energy_bar_value_changed
signal change_energy
signal preview_energy_cost
signal stop_energy_preview

signal activity_done

signal unlock_room

signal trigger_popup
signal dismiss_popup

signal ping_energy_bar
signal pong_energy_bar

signal progress_hour
signal progress_day
signal sleep_till_6

signal is_sleeping
signal is_bed_made
signal reset_day

signal clickable_chore_completed
signal clickable_clicked

signal pan_camera

var is_paused: bool = false
var in_clickable: bool = false
var can_autosleep: bool = true

var actual_energy: int = 8

var healed_fragments: int = 0
var healed_fragments_diff: int = 0

var unlockedRooms: float = 1.0

enum Rooms{BEDROOM, BATHROOM, KITCHEN}
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
