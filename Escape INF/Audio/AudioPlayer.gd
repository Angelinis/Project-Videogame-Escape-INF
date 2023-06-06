extends Node

onready var music_bus := AudioServer.get_bus_index("Music")
onready var sound_bus := AudioServer.get_bus_index("Sound")
onready var music_playing = false

func _ready(): # Ajusta o volume antes de iniciar o jogo
	AudioServer.set_bus_volume_db(music_bus, linear2db(0.3))
	AudioServer.set_bus_volume_db(sound_bus, linear2db(0.4))

func play_one_shot(audio, bus: String):
	var audioStreamPlayer = play_audio(audio, bus)
	audioStreamPlayer.autoplay = false

func play_audio(audio, bus: String):
	var audioStreamPlayer = AudioStreamPlayer.new()
	audioStreamPlayer.stream = audio
	audioStreamPlayer.bus = bus
	audioStreamPlayer.connect("finished", self, "on_audio_finished", [audioStreamPlayer])
	add_child(audioStreamPlayer)
	audioStreamPlayer.play()
	
	return audioStreamPlayer
	
func on_audio_finished(audioStreamPlayer):
	audioStreamPlayer.queue_free()

func stop_all_audios():
	for audioPlayer in get_children():
		audioPlayer.queue_free()
