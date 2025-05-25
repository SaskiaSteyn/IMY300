extends TextureProgressBar

func _ready():
	#var r = remap(value, 0, 100, 1, 0)
	#var g = remap(value, 0, 100, 0, 1)
	#var styleBox = get("theme_override_styles/fill")
	#styleBox.bg_color = Color(r, g, 0)
	Global.energy_bar_value_changed.emit(value)
	Global.change_energy.connect(_change_energy.bind())
	Global.ping_energy_bar.connect(_pong_energy_bar.bind())


func _on_value_changed(value: float) -> void:
	Global.energy_bar_value_changed.emit(value)
	
func _change_energy(change_value: int) -> void:
	_flicker_bar_change(value, change_value)
	value += (change_value * step)
	
func _pong_energy_bar() -> void:
	Global.pong_energy_bar.emit(value/step)
	
func _flicker_bar_change(old_value: float, change_value: float) -> void:
	var new_value = value + (change_value * step)
	for i in range(6):
		await get_tree().create_timer(0.3).timeout
		if value == old_value:
			value = new_value
		else:
			value = old_value
