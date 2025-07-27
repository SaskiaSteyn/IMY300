extends TextureProgressBar

var preview_energy_cost: bool = false

func _ready():
	#var r = remap(value, 0, 100, 1, 0)
	#var g = remap(value, 0, 100, 0, 1)
	#var styleBox = get("theme_override_styles/fill")
	#styleBox.bg_color = Color(r, g, 0)
	Global.energy_bar_value_changed.emit(value)
	Global.change_energy.connect(_change_energy.bind())
	Global.ping_energy_bar.connect(_pong_energy_bar.bind())
	Global.preview_energy_cost.connect(_preview_energy_cost.bind())
	Global.stop_energy_preview.connect(_stop_energy_preview.bind())
	
	
func _change_energy(change_value: int) -> void:
	var new_value = (Global.actual_energy * step) + (change_value * step)
	var old_value = (Global.actual_energy * step)
	for i in range(6):
		var temp = await _flicker_bar_on_change(old_value, new_value)
	value += (change_value * step)
	Global.actual_energy += change_value
	Global.energy_bar_value_changed.emit(value)
	
func _pong_energy_bar() -> void:
	Global.pong_energy_bar.emit(value/step)
	
func _flicker_bar_on_change(old_value: float, new_value: float) -> float:
	await get_tree().create_timer(0.3).timeout
	if value == old_value:
		value = new_value
	else:
		value = old_value
	return value
			
func _preview_energy_cost(change_value: float) -> void:
	print("previewing energy cost: " + str(change_value))
	preview_energy_cost = true
	var new_value = (Global.actual_energy * step) + (change_value * step)
	var old_value = (Global.actual_energy * step)
	while(preview_energy_cost):
		var temp = await _flicker_bar_on_change(old_value, new_value)
	print("Resetting to old value: " + str(old_value))
	value = (Global.actual_energy * step)
	
func _stop_energy_preview() -> void:
	preview_energy_cost = false
