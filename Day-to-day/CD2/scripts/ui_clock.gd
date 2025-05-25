extends RichTextLabel

@onready var tick = preload("res://assets/sfx/tick.mp3")
@onready var alarm = preload("res://assets/sfx/alarm.mp3")

func _ready() -> void:
	Global.progress_hour.connect(_progress_hour.bind())
	Global.progress_day.connect(_progress_day.bind())
	_update_time_text()
	
	
func _progress_hour() -> void:
	Global.current_time.hour = Global.current_time.hour + 1
	AudioPlayer.playOnce(tick)
	if Global.current_time.hour == 24:
		Global.current_time.hour = 0
		Global.current_time.day += 1
		AudioPlayer.playOnce(tick)
	_update_time_text()
	
func _progress_day() -> void:
	Global.is_speeding_up_time = true
	Global.in_clickable = true
	var wait_time: float = 1
	while Global.current_time.hour != 6:
		await get_tree().create_timer(wait_time).timeout
		Global.progress_hour.emit()
		if(wait_time > 0.25):
			wait_time /= 2
	
	AudioPlayer.playOnce(alarm)
	Global.in_clickable = false
	Global.is_speeding_up_time = false
	Global.making_bed.emit(false)
	Global.reset_day.emit()
		
	
		
		
	
func _update_time_text() -> void:
	self.text = "Day " + ("%02d" % Global.current_time.day) + ", " + ("%02d" % Global.current_time.hour) + ":" + ("%02d" % Global.current_time.minute)
	
