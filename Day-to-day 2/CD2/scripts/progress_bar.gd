extends ProgressBar

func _ready():
	var r = remap(value, 0, 100, 1, 0)
	var g = remap(value, 0, 100, 0, 1)
	var styleBox = get("theme_override_styles/fill")
	styleBox.bg_color = Color(r, g, 0)
	Global.energy_bar_value_changed.emit(value)
	Global.change_energy.connect(_change_energy.bind())
	Global.ping_energy_bar.connect(_pong_energy_bar.bind())


func _on_value_changed(value: float) -> void:
	Global.energy_bar_value_changed.emit(value)
	
func _change_energy(change_value: int) -> void:
	value += change_value
	
func _pong_energy_bar() -> void:
	Global.pong_energy_bar.emit(value)
