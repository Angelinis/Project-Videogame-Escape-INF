extends Area2D


export(Resource) var audio



func _on_HoverInfo_mouse_entered():
	if audio:
		AudioPlayer.stop_all_audios_bus("MenuSpeech")
		AudioPlayer.play_one_shot(audio, "MenuSpeech") 
	
