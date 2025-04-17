extends Node

signal player_exit_room
signal player_enter_room

enum Rooms{BEDROOM, BATHROOM, KITCHEN}
var going_to_room: Rooms
