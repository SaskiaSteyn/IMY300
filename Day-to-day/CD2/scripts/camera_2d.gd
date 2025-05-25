extends Camera2D

var ZoomMin = Vector2(0.25,0.25)
var ZoomMax = Vector2(2.5,2.5)
var ZoomSpd = Vector2(0.3,0.3)
var PanSpeedKey = 5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("ScrollZoomOut"):
		if zoom > ZoomMin:
			zoom -= ZoomSpd
	if event.is_action_pressed("ScrollZoomIn"):
		if zoom < ZoomMax:
			zoom +=ZoomSpd
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("MoveCamUp"):
		if ((position.y - get_viewport().size.y/2) < limit_top):
			position.y -= PanSpeedKey
	if Input.is_action_pressed("MoveCamDown"):
		if ((position.y + get_viewport().size.y/2) > limit_bottom):
			position.y += PanSpeedKey
	if Input.is_action_pressed("MoveCamLeft"):
		if ((position.x - get_viewport().size.x/2) > limit_left):
			position.x -= PanSpeedKey
	if Input.is_action_pressed("MoveCamRight"):
		if ((position.x + get_viewport().size.x/2) < limit_right):
			position.x += PanSpeedKey
