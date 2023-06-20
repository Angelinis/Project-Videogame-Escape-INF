extends Panel

onready var pause = false

const MAIN_MENU_PATH = "res://Interface/MainMenu/MainMenu.tscn"

func _on_PauseMenuRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			show()
			Blur.unfocus_blur()
			get_tree().paused = true
			
func _on_Resume_pressed():
	hide()
	Blur.visible = false
	get_tree().paused = false

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_SPACE and pause == false:
			pause = true
			show()
			Blur.unfocus_blur()
			get_tree().paused = true
		elif event.pressed and event.scancode == KEY_SPACE and pause == true:
			hide()
			Blur.visible = false
			get_tree().paused = false	
			pause = false

func _on_MainMenuButton_pressed():
	get_tree().paused = false
	SceneTransition.transition_scene(MAIN_MENU_PATH)

#var selectedButtonIndex = 0
#
#func _input(event):
#	if event is InputEventKey and event.is_pressed():
#		if event.scancode == KEY_DOWN:
#			select_next_button()
#		elif event.scancode == KEY_UP:
#			select_previous_button()
#		elif event.scancode == KEY_ENTER:
#			select_current_button()
#
#func select_next_button():
#	selectedButtonIndex += 1
#	if selectedButtonIndex >= 3:
#		selectedButtonIndex = 0
#
#	update_button_selection()
#
#func select_previous_button():
#	selectedButtonIndex -= 1
#	if selectedButtonIndex < 0:
#		selectedButtonIndex = 2
#
#	update_button_selection()
#
#func select_current_button():
#	match selectedButtonIndex:
#		0:
#			_on_Resume_pressed()
#		1:
#			print("Sound")
#		2:
#			print("Music")
#		3:	
#			print("MenuSpeech")
#		4:
#			_on_MainMenuButton_pressed()
#
#var SOUNDMENU1 = preload("res://Audio/AudioInclusive/MainMenu/main_menu_jogar_voice_text.mp3")
#var SOUNDMENU2 = preload("res://Audio/AudioInclusive/MainMenu/main_menu_como_jogar_voice_text.mp3")
#var SOUNDMENU3 = preload("res://Audio/AudioInclusive/MainMenu/main_menu_sair_voice_text.mp3")
#var SOUNDMENU4 = preload("res://Audio/AudioInclusive/MainMenu/main_menu_continuar_voice_text.mp3")
#var SOUNDARRAY = [SOUNDMENU1, SOUNDMENU2, SOUNDMENU3, SOUNDMENU4]
#
#
#func update_button_selection():
#	for i in range($Buttons.get_child_count()):
#		var button = $Buttons.get_child(i)
#
#		if i == selectedButtonIndex:
#			if i ==0 and $Buttons/PlayButton.text == "CONTINUAR":
#				i = 3
#			button.add_color_override("font_color", Color(1, 1, 1))
#			AudioPlayer.play_one_shot(SOUNDARRAY[i], "MenuSpeech") 
#		else:
#			button.add_color_override("font_color", Color(0.5, 0.5, 0.5))
