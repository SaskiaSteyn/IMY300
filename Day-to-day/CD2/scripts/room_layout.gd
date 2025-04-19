extends Room

@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D
@onready var path : Path2D = $Path2D
@onready var chore_sprite: StaticBody2D = $"chore-sprite"
#will be px per second
#ALERT: Change this back to 100
@export var speed = 300

#ALERT: This needs to be set to true for at least one room!
@export var starts_with_player: bool = false
@export var room_name: Global.Rooms = Global.Rooms.BEDROOM

var is_player_in_room: bool = false
var player: Player
var is_exiting: bool = false

func _ready()-> void:
	print("Readying room")
	Global.player_enter_room.connect(_player_enter_room.bind())
	Global.player_exit_room.connect(_player_exit_room.bind())
	if(starts_with_player):
		print("Adding player")
		is_player_in_room = true;
		chore_sprite.is_player_in_room = true
		player = load("res://scenes/player.tscn").instantiate()
		path_follow.add_child(player);
		Global.is_walking = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_player_in_room):
		path_follow.progress += speed * delta
		
		if(Global.is_walking and path_follow.progress_ratio == 1.0 and !is_exiting):
			Global.is_walking = false
			
		if(is_exiting and path_follow.progress_ratio == 1):
			path.curve.remove_point(2)
			path_follow.get_children()[0].queue_free()
			path_follow.progress_ratio = 0
			is_player_in_room = false
			chore_sprite.is_player_in_room = false
			is_exiting = false
			Global.player_enter_room.emit()
	
	
func _player_enter_room()-> void: 
	if(Global.going_to_room == room_name):
		print("player entering room")
		player = load("res://scenes/player.tscn").instantiate()
		path_follow.add_child(player)
		is_player_in_room = true
		chore_sprite.is_player_in_room = true
	
func _player_exit_room()-> void:
	if(is_player_in_room): 
		print("Player exiting room")
		is_exiting = true
		player._flip_sprite()
		path.curve.add_point(Vector2(-607, 153))
		


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and !is_player_in_room and !Global.is_walking):
			Global.going_to_room = room_name
			Global.player_exit_room.emit()
			Global.is_walking = true
			
			
			
			
