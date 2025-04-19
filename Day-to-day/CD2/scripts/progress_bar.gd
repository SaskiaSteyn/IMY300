extends ProgressBar

func _ready():
	var r = remap(value, 0, 100, 1, 0)
	var g = remap(value, 0, 100, 0, 1)
	var styleBox = get("theme_override_styles/fill")
	styleBox.bg_color = Color(r, g, 0)
	Global.energy_bar_value_changed.emit(value)
	Global.reduce_energy.connect(_reduce_energy.bind())


func _on_value_changed(value: float) -> void:
	Global.energy_bar_value_changed.emit(value)
	
func _reduce_energy(reduce_value: int) -> void:
	value -= reduce_value
