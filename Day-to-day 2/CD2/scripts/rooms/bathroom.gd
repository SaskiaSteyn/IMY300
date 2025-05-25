extends Room

#will be px per second
#ALERT: Change this back to 100
@export var speed = 300

#ALERT: This needs to be set to true for at least one room!


func _init()-> void:
	exit_point_vector = Vector2(-349, 153)
	#print("Readying room")
	#Global.player_enter_room.connect(_player_enter_room.bind())
	#Global.player_exit_room.connect(_player_exit_room.bind())
	#if(starts_with_player):
		#print("Adding player")
		#is_player_in_room = true;
		#chore_sprite.is_player_in_room = true
		#player = load("res://scenes/player.tscn").instantiate()
		#path_follow.add_child(player);
		#Global.is_walking = true


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
			for chore in chores:
				chore.is_player_in_room = false
			is_exiting = false
			Global.player_enter_room.emit()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and !is_player_in_room and !Global.is_walking):
			print(room_name)
			Global.going_to_room = room_name
			Global.player_exit_room.emit()
			Global.is_walking = true
