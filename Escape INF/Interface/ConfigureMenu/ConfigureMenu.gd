extends Panel

onready var pause = false

signal rightEmitted
signal leftEmitted

var selectedOption = 1
var audioSlider

const TRIAL_AUDIO = preload("res://Interface/TextBox/CharSFX.wav")

var SOUNDMENU1 = preload("res://Audio/AudioInclusive/ConfigureMenu/configure_menu_retomar.mp3")
var SOUNDMENU2 = preload("res://Audio/AudioInclusive/ConfigureMenu/configure_menu_efeitos_sonoros.mp3")
var SOUNDMENU3 = preload("res://Audio/AudioInclusive/ConfigureMenu/configure_menu_musica.mp3")
var SOUNDMENU4 = preload("res://Audio/AudioInclusive/ConfigureMenu/configure_menu_som_do_menu.mp3")
var SOUNDMENU5 = preload("res://Audio/AudioInclusive/ConfigureMenu/configure_menu_dialogos.mp3")
var SOUNDMENU6 = preload("res://Audio/AudioInclusive/ConfigureMenu/configure_menu_som_da_interface.mp3")
var SOUNDMENU7 = preload("res://Audio/AudioInclusive/ConfigureMenu/configure_menu_menu_principal.mp3")
var SOUNDARRAY = [SOUNDMENU1, SOUNDMENU2, SOUNDMENU3, SOUNDMENU4, SOUNDMENU5, SOUNDMENU6, SOUNDMENU7]
var SOUNDMENU8 = preload("res://Audio/AudioInclusive/ConfigureMenu/configure_menu_increase_decrease_sound.mp3")
var SOUNDMENU9 = preload("res://Audio/AudioInclusive/ConfigureMenu/configure_menu_configuracoes_iniciacao.mp3")

const MAIN_MENU_PATH = "res://Interface/MainMenu/MainMenu.tscn"

var rightKeyPressed = false
var leftKeyPressed = false

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
			print("here")
			pause = true
			show()
			Blur.unfocus_blur()
			get_tree().paused = true
			#Play an audio when opening the configuration menu
			AudioPlayer.stop_all_audios_bus("MenuSpeech")
			AudioPlayer.play_one_shot(SOUNDMENU9, "MenuSpeech")
		elif event.pressed and event.scancode == KEY_SPACE and pause == true:
			hide()
			Blur.visible = false
			get_tree().paused = false	
			pause = false
		elif event.pressed and event.scancode == KEY_DOWN and pause:
			selectedOption += 1
			if selectedOption >= 8:
				selectedOption = 1

			adjustSelectedOption()
		elif event.pressed and event.scancode == KEY_UP and pause:
			selectedOption -= 1
			
			if selectedOption <= 0:
				selectedOption = 7
			
			adjustSelectedOption()
		elif event.pressed and event.scancode == KEY_ENTER and pause:
			handleSelectedOption()
			
		elif event.pressed and event.scancode == KEY_RIGHT and pause:
			emit_signal("rightEmitted")
			
		elif event.pressed and event.scancode == KEY_LEFT and pause:
			emit_signal("leftEmitted")
			
			
func adjustSelectedOption():
	for i in range(1, 8):
		var button = $VBoxContainer.get_child(i)
		
		if i == selectedOption:
			if $VBoxContainer.get_child(i).has_node("SoundSlider"):
				audioSlider = $VBoxContainer.get_child(i).get_node("SoundSlider")
			else:
				audioSlider = null
			button.add_color_override("font_color", Color(1, 1, 1))
			AudioPlayer.stop_all_audios_bus("MenuSpeech")
			AudioPlayer.play_one_shot(SOUNDARRAY[i-1], "MenuSpeech") 
		else:
			button.add_color_override("font_color", Color(0.5, 0.5, 0.5))
			
func onRightEmitted():
	rightKeyPressed = true
	if audioSlider == null :
		return ""
	else: 
		audioSlider.value += 0.1 
#		AudioPlayer.stop_all_audios_bus(audioSlider.audio_bus_name)
		AudioPlayer.play_one_shot(TRIAL_AUDIO, audioSlider.audio_bus_name)
		if audioSlider.value > 1.0:
			audioSlider.value = 1.0


func onLeftEmitted():
	leftKeyPressed = true
	if audioSlider == null :
		return ""
	else: 
		audioSlider.value -= 0.1  
		AudioPlayer.play_one_shot(TRIAL_AUDIO, audioSlider.audio_bus_name)
		if audioSlider.value < 0.0:
			audioSlider.value = 0.0


func handleSelectedOption():
	match selectedOption:
		1:
			_on_Resume_pressed()
		2:
			print("Sound")
		3:
			print("Music")
		4:	
			print("MenuSound")
		5:	
			print("Dialogues")
		6:	
			print("UI Sound")
		7:	
			_on_MainMenuButton_pressed()


func _on_MainMenuButton_pressed():
	get_tree().paused = false
	SceneTransition.transition_scene(MAIN_MENU_PATH)


# Connect signals to corresponding functions
func _ready():
# warning-ignore:return_value_discarded
	connect("rightEmitted", self, "onRightEmitted")
# warning-ignore:return_value_discarded
	connect("leftEmitted", self, "onLeftEmitted")
