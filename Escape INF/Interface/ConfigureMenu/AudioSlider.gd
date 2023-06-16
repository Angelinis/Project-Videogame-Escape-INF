extends HSlider

export(String, "Master", "Music", "Sound", "MenuSpeech", "CharacterSpeech") var audio_bus_name := "Master"

onready var _bus := AudioServer.get_bus_index(audio_bus_name)

func _ready():
	value = db2linear(AudioServer.get_bus_volume_db(_bus))	
	for i in AudioServer.get_bus_count():
		print(AudioServer.get_bus_name(i))
	

func _on_SoundSlider_value_changed(value: float):
	AudioServer.set_bus_volume_db(_bus, linear2db(value))
