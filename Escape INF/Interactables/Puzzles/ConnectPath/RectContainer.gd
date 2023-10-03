extends Control

var completed = false
var isMouseOverPanel = false
var selected_index

onready var panels = get_children()

var SOUND1 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_1.mp3")
var SOUND2 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_2.mp3")
var SOUND3 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_3.mp3")
var SOUND4 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_4.mp3")
var SOUND5 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_5.mp3")
var SOUND6 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_6.mp3")
var SOUND7 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_7.mp3")
var SOUND8 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_8.mp3")
var SOUND9 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_9.mp3")
var SOUND10 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_10.mp3")
var SOUND11 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_11.mp3")
var SOUND12 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_12.mp3")
var SOUND13 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_13.mp3")
var SOUND14 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_14.mp3")
var SOUND15 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_fim.mp3")
var SOUND16 = preload("res://Audio/AudioInclusive/HoverInfo/Lab257/hover_info_circuito_inicio.mp3")
var SOUNDARRAY = [SOUND1, SOUND2, SOUND3, SOUND4, SOUND5, SOUND6, SOUND7, SOUND15, SOUND8, SOUND9, SOUND10, SOUND11, SOUND16, SOUND12, SOUND13, SOUND14]

onready var destinyButton = $TextureRect8

func _ready():
	selected_index = 0
	for i in panels.size():
		panels[i].connect("gui_input", self, "_on_panel_gui_input", [i])
		panels[i].connect("mouse_entered", self, "_on_panel_mouse_entered", [i])
		panels[i].connect("mouse_exited", self, "_on_panel_mouse_exited")
	randomize_rotations()
		
func _on_panel_mouse_entered(index):
	isMouseOverPanel = true
	AudioPlayer.stop_all_audios_bus("MenuSpeech")
	AudioPlayer.play_one_shot(SOUNDARRAY[index], "MenuSpeech") 
	
func _on_panel_mouse_exited():
	isMouseOverPanel = false

func _input(event):
	if not completed:
			if event is InputEventKey:
				if event.scancode == KEY_TAB and event.pressed:
					
					if selected_index + 1 >= panels.size():  
						AudioPlayer.stop_all_audios_bus("MenuSpeech")
						AudioPlayer.play_one_shot(SOUNDARRAY[selected_index], "MenuSpeech")	 
						selected_index = 0
					elif selected_index == 6 or selected_index == 11: 
						AudioPlayer.stop_all_audios_bus("MenuSpeech")
						AudioPlayer.play_one_shot(SOUNDARRAY[selected_index], "MenuSpeech")
						selected_index += 2
					else: 
						AudioPlayer.stop_all_audios_bus("MenuSpeech")
						AudioPlayer.play_one_shot(SOUNDARRAY[selected_index], "MenuSpeech")
						selected_index += 1
						
					 
					
				elif event.scancode == KEY_ENTER and event.pressed:
					# Handle Enter key pressed (change rotation)
					if selected_index != 7 and selected_index != 12:
						panels[selected_index].rect_rotation += 90
						if panels[selected_index].rect_rotation > 270:
							panels[selected_index].rect_rotation = 0
							
						if check_completion() == true:
							destinyButton.texture = load("res://Interactables/Puzzles/ConnectPath/greenLight.png")
							get_parent().complete()
							completed = true
		
func _on_panel_gui_input(event, index):
	if not completed and isMouseOverPanel:
		if index != 7 and index != 12:
			if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
				# Handle left mouse button click (change rotation)
				if index != 7 and index != 12:
					panels[index].rect_rotation += 90
					if panels[index].rect_rotation > 270:
						panels[index].rect_rotation = 0
						
					if check_completion() == true:
						destinyButton.texture = load("res://Interactables/Puzzles/ConnectPath/greenLight.png")
						get_parent().complete()
						completed = true
					
func randomize_rotations():
	
	randomize()
	
	var values = [0,90,180,270]
	
	for i in panels.size():
		if i != 7 and i != 12:
			panels[i].rect_rotation = values[randi() % values.size()]

func check_completion():
	for i in panels.size():
		if panels[i].rect_rotation == 0:
			if i in [1,2,3,4,5,9,10,11,13,15]:
				return false
		if panels[i].rect_rotation == 90:
			if i in [0,4,8,10,13,14,15]:
				return false
		if panels[i].rect_rotation == 180:
			if i in [0,1,2,3,4,5,6,8,9,10,11,13]:
				return false
		if panels[i].rect_rotation == 270:
			if i in [0,3,6,9,11,14,15]:
				return false
	return true
