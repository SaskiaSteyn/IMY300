extends Node2D
class_name Clickable

@onready var clickable = $StaticBody2D/Clickable
@onready var finalPositionSprite = $FinalPositionSprite

var is_clicked: bool = false

var accepting_input: bool = false

func _ready() -> void:
	await get_tree().create_timer(0.1).timeout
	accepting_input = true

func _on_mouse_entered() -> void:
	print("Mouse entered")
	var material: ShaderMaterial = clickable.material
	material.set_shader_parameter("width", 10)

			
func _on_mouse_exited() -> void:
	var material: ShaderMaterial = clickable.material
	material.set_shader_parameter("width", 0)
	material.set_shader_parameter("outline_color", Color(1, 1, 1, 1))
	
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT and accepting_input):
			Global.mouse_click()
			finalPositionSprite.visible = true
			is_clicked = true
			clickable.visible = false
			Global.clickable_clicked.emit()
