extends Node
class_name AudioPlayer

static func play() -> void: 
	var audio_player := AudioStreamPlayer2D.new()
	var bg_music = load("res://assets/music/main_soundtrack.mp3")
	audio_player.stream = bg_music
	audio_player. autoplay = true
	audio_player.stream.loop = true
	audio_player.volume_db = -1.0
	Engine.get_main_loop().root.add_child(audio_player)

static func playOnce(audio: AudioStream) -> void:
	var audio_player := AudioStreamPlayer2D.new()
	audio_player.stream = audio
	audio_player.autoplay = true
	Engine.get_main_loop().root.add_child(audio_player)
	await audio_player.finished
	audio_player.queue_free()
