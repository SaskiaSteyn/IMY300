extends StaticBody2D
class_name Room

@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D
@onready var path : Path2D = $Path2D
#@onready var chore_sprite: StaticBody2D = $"chore-sprite"

@export var starts_with_player: bool = false
@export var room_name: Global.Rooms = Global.Rooms.BEDROOM

var is_player_in_room: bool = false
var player: Player
var is_exiting: bool = false
var chores: Array = []
var exit_point_vector: Vector2 = Vector2(0,0)

func _ready()-> void:
	print("Readying room")
	Global.player_enter_room.connect(_player_enter_room.bind())
	Global.player_exit_room.connect(_player_exit_room.bind())
	
	var children = get_children()
	
	for child in children:
		if child.is_in_group("chores"):
			chores.append(child)
	
	if(starts_with_player):
		print("Adding player")
		is_player_in_room = true;
		for chore in chores:
			chore.is_player_in_room = true
		player = load("res://scenes/player.tscn").instantiate()
		path_follow.add_child(player);
		Global.is_walking = true
		Global.curr_room = self
		
func _player_enter_room()-> void: 
	if(Global.going_to_room == room_name):
		print("player entering room")
		player = load("res://scenes/player.tscn").instantiate()
		path_follow.add_child(player)
		is_player_in_room = true
		for chore in chores:
			chore.is_player_in_room = true
		Global.curr_room = self
	
func _player_exit_room()-> void:
	if(is_player_in_room): 
		print("Player exiting room")
		is_exiting = true
		player._flip_sprite()
		path.curve.add_point(exit_point_vector)
