extends Panel

onready var pause = false

var selectedOption = 1


#var CONFIGURE_MENU_OPTIONS = [$VBoxContainer/Resume, $VBoxContainer/Sound/Label,
#							$VBoxContainer/Music/Label, $VBoxContainer/MenuSpeech/Label,
#							$VBoxContainer/CharacterSpeech/Label, $VBoxContainer/UISound/Label, $VBoxContainer/MainMenuButton]

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
			
			
func adjustSelectedOption():
	
	for i in range(1,8):
		var button = $VBoxContainer.get_child(i)
		
		if i == selectedOption:
			button.add_color_override("font_color", Color(1, 1, 1))
#			AudioPlayer.play_one_shot(SOUNDARRAY[i], "MenuSpeech") 
		else:
			button.add_color_override("font_color", Color(0.5, 0.5, 0.5))



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
	
	
