extends Node

@onready var done = preload("res://assets/sfx/melancholy-ui-chime-47804.mp3")
@onready var click = preload("res://assets/sfx/select.wav")

func _ready() -> void:
	Global.activity_done.connect(_activity_done.bind())
	Global.trigger_popup.connect(_trigger_popup.bind())
	Global.unlock_room.connect(_unlock_room.bind())
	
func _activity_done(activity: Activity) -> void:
	AudioPlayer.playOnce(done)
	_activity_modify_energy(activity)
	_activity_execute_rewards(activity)
	_activity_execute_unlockables(activity)
	
func _unhandled_input(event) -> void:
	if event is InputEventMouseButton:
		if (event.pressed and event.button_index == MOUSE_BUTTON_LEFT):
			AudioPlayer.playOnce(click)
	if event is InputEventKey:
		if(event.pressed and event.keycode == KEY_ESCAPE):
			var pop_up_menu= load("res://scenes/popups/pause_screen.tscn").instantiate()
			_trigger_popup(pop_up_menu)
	
func _activity_check_day(activity: Activity) -> void:
	pass
	
func _activity_modify_energy(activity: Activity) -> void:
	Global.change_energy.emit(activity.energy_streak_map[activity.current_streak])

func _activity_execute_gain() -> void:
	pass

func _activity_execute_loss() -> void:
	pass

func _activity_execute_rewards(activity: Activity) -> void:
	if(activity.rewards_map.has(activity.current_streak)):
		activity.rewards_map[activity.current_streak].call()
	
func _activity_execute_unlockables(activity: Activity) -> void:
	if(activity.unlockables_map.has(activity.current_streak)):
		activity.unlockables_map[activity.current_streak].call()
		
func _trigger_popup(popup: Node) -> void:
	get_node("../../Level Assets/Camera2D/Popups").add_child(popup)
		
func _unlock_room(unlock_room: Global.Unlock_Room) -> void:
	match unlock_room:
		Global.Unlock_Room.BATHROOM: 
			get_node("../../Level Assets/Bathroom").visible = true
		Global.Unlock_Room.KITCHEN: 
			get_node("../../Level Assets/Kitchen").visible = true
		_: 
			print("no match found")
			
	Global.ping_energy_bar.emit()
	
