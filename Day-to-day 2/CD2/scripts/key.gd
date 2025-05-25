extends CharacterBody2D

var unlocking_room: Global.Unlock_Room
var has_jumped: bool = false
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	if(!has_jumped):
		velocity.y =  JUMP_VELOCITY
		has_jumped = true
	move_and_slide()

func _set_unlocking_room(room: Global.Unlock_Room) -> void:
	unlocking_room = room
	
func unlock() -> void:
	match unlocking_room:
		Global.Unlock_Room.BATHROOM: 
			Global.unlock_room.emit(unlocking_room)
			queue_free()
		Global.Unlock_Room.KITCHEN: 
			Global.unlock_room.emit(unlocking_room)
			queue_free() 
		_: 
			print("no match found")


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if  event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
			unlock()
