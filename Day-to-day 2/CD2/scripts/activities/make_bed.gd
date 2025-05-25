extends Activity

@onready var sprite = $Sprite2D
@onready var making_bed = preload("res://assets/sfx/making bed_mixdown.wav")

var is_player_in_room: bool = false
var bed_is_made: bool = false



func _init():
	super(gain_fun, loss_fun)
	energy_streak_map = {
		0: -70,
		1: -30,
		2: -20,
		3: -20,
		4: -10
	}
	
	unlockables_map = {
		0: unlockable_func_day_zero
	}

var gain_fun = func(x):
	print(x)
	
var loss_fun = func(x):
	print(x)

var unlockable_func_day_zero = func(): 
	var key_scene = load("res://scenes/key.tscn").instantiate()
	Global.curr_room.add_child(key_scene)

func _on_mouse_entered() -> void:
	if(is_player_in_room and !bed_is_made):
		if(is_activity_doable):
			var material: ShaderMaterial = sprite.material
			material.set_shader_parameter("width", 10)
		else:
			var material: ShaderMaterial = sprite.material
			material.set_shader_parameter("width", 10)
			material.set_shader_parameter("outline_color", Color(1, 0, 0, 1))


func _on_mouse_exited() -> void:
	var material: ShaderMaterial = sprite.material
	material.set_shader_parameter("width", 0)
	material.set_shader_parameter("outline_color", Color(1, 1, 1, 1))


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_player_in_room and !Global.is_walking and !bed_is_made and is_activity_doable):
			AudioPlayer.playOnce(making_bed)
			var tween = get_tree().create_tween()
			tween.tween_property(sprite, "rotation_degrees", 360, 1).set_trans(Tween.TRANS_SINE)
			tween.tween_property(sprite, "rotation_degrees", 0, 1).set_trans(Tween.TRANS_SINE)
			tween.tween_callback(_make_bed)
			bed_is_made = true
			
			
func _make_bed() -> void:
	sprite.rotation_degrees = 0
	var made_bed = load("res://assets/art/bed-sprite.png")
	sprite.texture = made_bed
	Global.activity_done.emit(self)
