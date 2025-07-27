extends Area2D
class_name Room

@onready var path_follow : PathFollow2D = $Path2D/PathFollow2D
@onready var path : Path2D = $Path2D
@onready var door : Sprite2D = $Door
#@onready var chore_sprite: StaticBody2D = $"chore-sprite"

@export var starts_with_player: bool = false
@export var room_name: Global.Rooms = Global.Rooms.BEDROOM

var is_player_in_room: bool = false
var player: Player
var is_exiting: bool = false
var chores: Array = []
var exit_point_vector: Vector2 = Vector2(0,0)

@export var unlock_room_popup: FlashBack = null
@export var flashback: VideoStream = null

func _ready()-> void:
	print("Readying room")
	Global.unlock_room.connect(unlock_room.bind())
	#Global.player_enter_room.connect(_player_enter_room.bind())
	#Global.player_exit_room.connect(_player_exit_room.bind())
	self.body_entered.connect(_on_body_entered.bind())
	self.body_exited.connect(_on_body_exited.bind())
	
	var children = get_children()
	
	for child in children:
		if child.is_in_group("chores"):
			chores.append(child)
	
	if(starts_with_player):
		print("Adding player")
		is_player_in_room = true;
		for chore in chores:
			chore.is_player_in_room = true
		#player = load("res://scenes/player.tscn").instantiate()
		#path_follow.add_child(player);
		#Global.is_walking = true
		Global.curr_room = self
		
#func _player_enter_room()-> void: 
	#if(Global.going_to_room == room_name):
		#print("player entering room")
		##player = load("res://scenes/player.tscn").instantiate()
		##path_follow.add_child(player)
		#is_player_in_room = true
		#for chore in chores:
			#chore.is_player_in_room = true
		#Global.curr_room = self
	#
#func _player_exit_room()-> void:
	#if(is_player_in_room): 
		#print("Player exiting room")
		#is_exiting = true
		##player._flip_sprite()
		##path.curve.add_point(exit_point_vector)
		
func _process(delta: float) -> void:
	if(is_player_in_room):
		var value: float = (Global.Rooms.size() - Global.unlockedRooms)/Global.Rooms.size()
		var modifier = remap(value, 0, 1, 150, 0)
			
		if(is_exiting):
			is_player_in_room = false
			for chore in chores:
				chore.is_player_in_room = false
			is_exiting = false

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and !is_player_in_room and !Global.is_walking and !Global.in_clickable):
			print(room_name)
			Global.mouse_click()
			Global.going_to_room = room_name
			Global.player_exit_room.emit()
			Global.is_walking = true
		
func _on_body_entered(body: Node2D) -> void:
	print(body.name + " entered " + self.name)
	if body.name == "Player":
		print("player entered " + self.name)
		is_player_in_room = true
		for chore in chores:
			chore.is_player_in_room = true
		Global.curr_room = self

func _on_body_exited(body: Node2D) -> void:
	print(body.name + " exited " + self.name)
	if body.name == "Player":
		print("player exited " + self.name)
		is_player_in_room = false
		for chore in chores:
			chore.is_player_in_room = false
		is_exiting = false
		
func unlock_room(unlocking_room: Global.Rooms) -> void:
	if(unlocking_room == room_name):
		print("unlocking " + Global.Rooms.keys()[room_name])
		door.visible = false
		for chore : Activity in chores:
			chore.is_locked = false
			chore.is_locked_for_day = true
		Global.unlockedRooms += 1
		if unlock_room_popup != null:
			Global.is_paused = true
			Global.trigger_popup.emit(unlock_room_popup)
		Global.pan_camera.emit(self)
		Global.ping_energy_bar.emit()
		
func pan_completed(node: Node2D) -> void:
	if(node.name == name):
		if unlock_room_popup != null:
			Global.is_paused = true
			var popup = unlock_room_popup.instantiate()
			popup.video = flashback
			Global.trigger_popup.emit(unlock_room_popup)
