extends Control

var salas = null

onready var labelNomeSala = $LabelNomeSalas
onready var salasControl = $Salas

func _ready():
	labelNomeSala.text = ""
	
	salas = salasControl.get_children()
	for i in range(salas.size()):
		salas[i].connect("mouse_entered", self, "on_sala_mouse_entered", [i])
		salas[i].connect("mouse_exited", self, "on_sala_mouse_exited")
		
func on_sala_mouse_entered(index):
	labelNomeSala.text = salas[index].nome
	
func on_sala_mouse_exited():
	labelNomeSala.text = ""

##########################################################
#
#func _input(event):
#	if event is InputEventKey and event.is_pressed():
#		if event.scancode == KEY_TAB:
#			select_next_button()
#		elif event.scancode == KEY_ENTER:
#			select_current_button()
#
#
#
#func _on_PlayButton_pressed():
#	if not ProgressManager.game_started:
#		SceneTransition.transition_scene(first_scene)
#		ProgressManager.game_started = true
#	else:
#		SceneTransition.transition_scene("res://Rooms/Lab257/Lab257.tscn")
#
#func _on_QuitButton_pressed():
#	get_tree().quit()
#
#func _on_TutorialButton_pressed():
#	var _b = get_tree().change_scene(tutorial_scene)
#
#
#
#
#func select_next_button():
#	selectedButtonIndex += 1
#	if selectedButtonIndex >= 3:
#		selectedButtonIndex = 0
#
#	update_button_selection()
#
#func select_current_button():
#	match selectedButtonIndex:
#		0:
#			_on_PlayButton_pressed()
#		1:
#			_on_TutorialButton_pressed()
#		2:
#			_on_QuitButton_pressed()
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
#
