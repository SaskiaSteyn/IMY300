extends Node2D
class_name Player

@onready var sprite = $Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

func _flip_sprite() -> void:
	sprite.flip_h = !sprite.flip_h


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.is_walking:
		sprite.play("walking")
	else:
		sprite.play("idle_side")
