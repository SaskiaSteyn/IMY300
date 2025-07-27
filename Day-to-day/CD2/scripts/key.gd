extends CharacterBody2D

var unlocking_room: Global.Rooms
var has_jumped: bool = false
const JUMP_VELOCITY = -300.0
var is_unlocked: bool = false

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	if(!has_jumped):
		velocity.y =  JUMP_VELOCITY
		has_jumped = true
	move_and_slide()

func _set_unlocking_room(room: Global.Rooms) -> void:
	unlocking_room = room
	
func unlock() -> void:
	if is_unlocked:
		return
	is_unlocked = true
	Global.unlock_room.emit(unlocking_room)
	queue_free()
	#match unlocking_room:
		#Global.Unlock_Room.BATHROOM:
			#print("unlocking bathroom")
			#
		#Global.Unlock_Room.KITCHEN: 
			#print("unlocking kitchen")
			#Global.unlock_room.emit(unlocking_room)
			#queue_free() 
		#_: 
			#print("no match found")


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
			Global.mouse_click()
			unlock()
