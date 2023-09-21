extends Area2D


export(Resource) var audio



func _on_HoverInfoPuzzles_mouse_entered():
	if audio:

		AudioPlayer.stop_all_audios_bus("MenuSpeech")
		AudioPlayer.play_one_shot(audio, "MenuSpeech") 

	
