extends Node

@onready var done = preload("res://assets/sfx/melancholy-ui-chime-47804.mp3")
@onready var click = preload("res://assets/sfx/mixkit-mouse-click-close-1113.wav")

func _ready() -> void:
	Global.activity_done.connect(_activity_done.bind())
	Global.trigger_popup.connect(_trigger_popup.bind())
	Global.unlock_room.connect(_unlock_room.bind())
	Global.reset_day.connect(_reset_day.bind())
	
	
#This is the main flow for when an activity is completed by the player.
func _activity_done(activity: Activity) -> void:
	AudioPlayer.playOnce(done)
	_activity_modify_energy(activity)
	_activity_execute_constant_func(activity)
	_activity_execute_events(activity)
	_activity_execute_unlockables(activity)
	_activity_progress_hour(activity)
	
func _unhandled_input(event) -> void:
	#if event is InputEventMouseButton:
		#if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
			#AudioPlayer.playOnce(click)
	if event is InputEventKey:
		if(event.pressed and event.keycode == KEY_ESCAPE and !Global.is_paused):
			print("Opening pause menu")
			var pop_up_menu= load("res://scenes/popups/pause_screen.tscn").instantiate()
			Global.is_paused = true
			Global.trigger_popup.emit(pop_up_menu)
	
func _activity_check_day(activity: Activity) -> void:
	pass
	
func _activity_modify_energy(activity: Activity) -> void:
	Global.change_energy.emit(activity.energy_streak_map[activity.current_streak])
	
func _activity_execute_constant_func(activity: Activity) -> void:
	if activity.constant_func != null:
		activity.constant_func.call()

func _activity_execute_gain() -> void:
	pass

func _activity_execute_loss() -> void:
	pass

func _activity_execute_events(activity: Activity) -> void:
	if(activity.events_map.has(activity.current_streak)):
		activity.events_map[activity.current_streak].call()
	
func _activity_execute_unlockables(activity: Activity) -> void:
	if(activity.unlockables_map.has(activity.current_streak)):
		activity.unlockables_map[activity.current_streak].call()
		
func _activity_progress_hour(activity:Activity) -> void:
	Global.progress_hour.emit()
	
		
func _trigger_popup(popup: Node) -> void:
	Global.in_clickable = true
	get_node("../../Level Assets/Camera2D/Popups/PopupSlot").add_child(popup)
	
func _dismissed_popup() -> void:
	Global.in_clickable = false
		
func _unlock_room(unlock_room: Global.Unlock_Room) -> void:
	match unlock_room:
		Global.Unlock_Room.BATHROOM: 
			get_node("../../Level Assets/Bathroom").visible = true
		Global.Unlock_Room.KITCHEN: 
			get_node("../../Level Assets/Kitchen").visible = true
			Global.is_paused = true
			var flashbackNode = load("res://scenes/popups/flashback.tscn").instantiate()
			Global.trigger_popup.emit(flashbackNode)
		_: 
			print("no match found")
			
	Global.ping_energy_bar.emit()
	
func _reset_day() -> void:
	get_tree().call_group("chores", "reset")
	Global.ping_energy_bar.emit()
	
