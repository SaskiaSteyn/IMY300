extends Node

signal player_exit_room
signal player_enter_room
signal energy_bar_value_changed
signal reduce_energy
signal activity_done

enum Rooms{BEDROOM, BATHROOM, KITCHEN}
var going_to_room: Rooms

var is_walking: bool = false

func _init():
	AudioPlayer.play()
