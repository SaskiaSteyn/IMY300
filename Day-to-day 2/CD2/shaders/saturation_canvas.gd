extends ColorRect

func _ready() -> void:
	Global.energy_bar_value_changed.connect(_change_saturation.bind())
	
	
func _change_saturation(value: float) -> void:
	var new_value = remap(value, 0, 100, 1, 0)
	color = Color(1, 1, 1, new_value)
