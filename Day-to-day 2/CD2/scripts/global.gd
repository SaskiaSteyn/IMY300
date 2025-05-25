extends Node

signal player_exit_room
signal player_enter_room
signal energy_bar_value_changed
signal change_energy
signal activity_done
signal unlock_room
signal trigger_popup
signal ping_energy_bar
signal pong_energy_bar

enum Rooms{BEDROOM, BATHROOM, KITCHEN}
enum Unlock_Room{BATHROOM, KITCHEN}
var going_to_room: Rooms

var is_walking: bool = false
var curr_room: Room

func _init():
	AudioPlayer.play()
