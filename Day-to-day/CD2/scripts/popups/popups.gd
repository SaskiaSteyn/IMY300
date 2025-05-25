extends CanvasLayer

@onready var shader = $PopupSaturationShader

func _ready() -> void:
	Global.trigger_popup.connect(_popup_triggered.bind())
	Global.dismiss_popup.connect(_popup_dismissed.bind())
	
func _popup_triggered(popup: Node) -> void:
	print("popups visible")
	visible = true
	if Global.is_paused:
		shader.visible = false
		
	
func _popup_dismissed() -> void:
	print("popups dismissed")
	shader.visible = true
	visible = false
	
