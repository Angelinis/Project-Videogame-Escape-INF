extends HBoxContainer

const CHANGE_VIEW_SOUND = preload("res://Audio/AudioInclusive/UI/ui_change_view.mp3")

onready var walls_manager = get_tree().get_current_scene().get_node("Walls")

func _on_LeftButtonRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				walls_manager.current_wall_index -= 1

func _on_RightButtonRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				walls_manager.current_wall_index += 1

func _input(event):
	if event is InputEventKey and walls_manager.window_open == false:
		if event.scancode == KEY_LEFT and event.pressed and TextBox.isTextShowing() == false:
			
			AudioPlayer.stop_all_audios_bus("CharacterSpeech")
			AudioPlayer.stop_all_audios_bus("MenuSpeech")
			
			walls_manager.current_wall_index -= 1
			AudioPlayer.play_audio(CHANGE_VIEW_SOUND, "UISound")
		elif event.scancode == KEY_RIGHT and event.pressed and TextBox.isTextShowing() == false:
			AudioPlayer.stop_all_audios_bus("CharacterSpeech")
			AudioPlayer.stop_all_audios_bus("MenuSpeech")
			walls_manager.current_wall_index += 1
			AudioPlayer.play_audio(CHANGE_VIEW_SOUND, "UISound")
		if event.scancode == KEY_L and event.pressed:
			ProgressManager.get_current_room_and_wall(walls_manager.current_wall_index)

