extends CanvasLayer

@onready var animationPlayer = $AnimationPlayer

func _ready() -> void:
	Global.progress_hour.connect(_eval_time.bind())
	
func _eval_time() -> void:
	await get_tree().create_timer(0.1).timeout
	match Global.current_time.hour:
		5:
			if Global.is_speeding_up_time:
				print("playing night_to_morning_quick")
				animationPlayer.play("night_to_morning_quick")
			else:
				print("playing night_to_morning")
				animationPlayer.play("night_to_morning")
		7:
			if Global.is_speeding_up_time:
				print("playing morning_to_day_quick")
				animationPlayer.play("morning_to_day_quick")
			else:
				print("playing morning_to_day")
				animationPlayer.play("morning_to_day")
		17:
			if Global.is_speeding_up_time:
				print("playing day_to_evening_quick")
				animationPlayer.play("day_to_evening_quick")
			else:
				print("playing day_to_evening")
				animationPlayer.play("day_to_evening")
		19:
			if Global.is_speeding_up_time:
				print("playing evening_to_night_quick")
				animationPlayer.play("evening_to_night_quick")
			else:
				print("playing evening_to_night")
				animationPlayer.play("evening_to_night")
		_:
			print("no match for time")
#		f2c1cb
#acc3e6
