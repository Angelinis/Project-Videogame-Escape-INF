extends Panel

onready var pause = false

var selectedOption = 0

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
			adjustSelectedOption()
		elif event.pressed and event.scancode == KEY_UP and pause:
			selectedOption -= 1
			adjustSelectedOption()
		elif event.pressed and event.scancode == KEY_ENTER and pause:
			handleSelectedOption()
			
			
func adjustSelectedOption():
	
	for i in range($VBoxContainer.get_child_count()):
		var button = $VBoxContainer.get_child(i)

		if i == selectedOption:
			button.add_color_override("font_color", Color(1, 1, 1))
#			AudioPlayer.play_one_shot(SOUNDARRAY[i], "MenuSpeech") 
		else:
			button.add_color_override("font_color", Color(0.5, 0.5, 0.5))


func handleSelectedOption():
	match selectedOption:
		0:
			_on_Resume_pressed()
		1:
			print("Sound")
		2:
			print("Music")
		3:	
			print("MenuSound")
		4:	
			print("Dialogues")
		5:	
			print("UI Sound")
		6:	
			_on_MainMenuButton_pressed()


func _on_MainMenuButton_pressed():
	get_tree().paused = false
	SceneTransition.transition_scene(MAIN_MENU_PATH)
	
	
