extends Control

export (String, FILE, "*.tscn") var first_scene
export (String, FILE, "*.tscn") var tutorial_scene

var SOUNDTRACK2 = preload("res://Audio/SFX/anime_soundtrack_inf.mp3")

func _ready():
	AudioPlayer.stop_all_audios_bus("UISound")
	AudioPlayer.stop_all_audios_bus("CharacterSpeech")
	Blur.visible = false
	if AudioPlayer.music_playing == false:
		AudioPlayer.play_audio(SOUNDTRACK2, "Music")
		AudioPlayer.music_playing = true


	if not ProgressManager.game_started:
		$Buttons/PlayButton.text = "JOGAR"
	else:
		$Buttons/PlayButton.text = "CONTINUAR"

func _on_PlayButton_pressed():
	if not ProgressManager.game_started:
		SceneTransition.transition_scene(first_scene)
		ProgressManager.game_started = true
	else:
		SceneTransition.transition_scene("res://Rooms/Lab257/Lab257.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_TutorialButton_pressed():
	var _b = get_tree().change_scene(tutorial_scene)

var selectedButtonIndex = 0

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_DOWN:
			select_next_button()
		elif event.scancode == KEY_UP:
			select_previous_button()
		elif event.scancode == KEY_ENTER:
			select_current_button()

func select_next_button():
	selectedButtonIndex += 1
	if selectedButtonIndex >= 3:
		selectedButtonIndex = 0

	update_button_selection()

func select_previous_button():
	selectedButtonIndex -= 1
	if selectedButtonIndex < 0:
		selectedButtonIndex = 2

	update_button_selection()

func select_current_button():
	match selectedButtonIndex:
		0:
			_on_PlayButton_pressed()
		1:
			_on_TutorialButton_pressed()
		2:
			_on_QuitButton_pressed()

var SOUNDMENU1 = preload("res://Audio/AudioInclusive/MainMenu/main_menu_jogar_voice_text.mp3")
var SOUNDMENU2 = preload("res://Audio/AudioInclusive/MainMenu/main_menu_como_jogar_voice_text.mp3")
var SOUNDMENU3 = preload("res://Audio/AudioInclusive/MainMenu/main_menu_sair_voice_text.mp3")
var SOUNDMENU4 = preload("res://Audio/AudioInclusive/MainMenu/main_menu_continuar_voice_text.mp3")
var SOUNDARRAY = [SOUNDMENU1, SOUNDMENU2, SOUNDMENU3, SOUNDMENU4]


func update_button_selection():
	for i in range($Buttons.get_child_count()):
		var button = $Buttons.get_child(i)

		if i == selectedButtonIndex:
			if i ==0 and $Buttons/PlayButton.text == "CONTINUAR":
				i = 3
			button.add_color_override("font_color", Color(1, 1, 1))
			AudioPlayer.play_one_shot(SOUNDARRAY[i], "MenuSpeech") 
		else:
			button.add_color_override("font_color", Color(0.5, 0.5, 0.5))


