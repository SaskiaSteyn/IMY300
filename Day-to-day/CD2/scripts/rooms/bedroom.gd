extends Room

#will be px per second
#ALERT: Change this back to 100
@export var speed = 50

@onready var make_bed = $make_bed
@onready var bed_sleep = $bed_sleep

#ALERT: This needs to be set to true for at least one room!


func _init()-> void:
	exit_point_vector = Vector2(-607, 153)
	Global.making_bed.connect(_make_bed.bind())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(is_player_in_room):
		var value: float = (Global.Unlock_Room.size() - Global.unlockedRooms)/Global.Unlock_Room.size()
		var modifier = remap(value, 0, 1, 150, 0)
		path_follow.progress += (speed + modifier) * delta
		
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
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and !is_player_in_room and !Global.is_walking and !Global.in_clickable):
			print(room_name)
			Global.mouse_click()
			Global.going_to_room = room_name
			Global.player_exit_room.emit()
			Global.is_walking = true
			
func _make_bed(is_bed_made: bool) -> void:
	if is_bed_made:
		make_bed.visible = false
		bed_sleep.visible = true
	else:
		make_bed.visible = true
		bed_sleep.visible = false
