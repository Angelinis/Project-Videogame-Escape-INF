extends Control

var salas = null

var selected_sala_index
var selected_sala

var LAB257 = preload("res://Audio/AudioInclusive/PlantaBaixa/lab257_planta_baixa.mp3")
var PATIO = preload("res://Audio/AudioInclusive/PlantaBaixa/patio_planta_baixa.mp3")
var LAB152 = preload("res://Audio/AudioInclusive/PlantaBaixa/lab152_planta_baixa.mp3")
var LAB251 = preload("res://Audio/AudioInclusive/PlantaBaixa/lab251_planta_baixa.mp3")
var SALASERGIO = preload("res://Audio/AudioInclusive/PlantaBaixa/salasergio_planta_baixa.mp3")
var COPA = preload("res://Audio/AudioInclusive/PlantaBaixa/copa_planta_baixa.mp3")
var NRC = preload("res://Audio/AudioInclusive/PlantaBaixa/nrc_planta_baixa.mp3")
var SECRETARIA = preload("res://Audio/AudioInclusive/PlantaBaixa/secretaria_planta_baixa.mp3")
var SAIDA = preload("res://Audio/AudioInclusive/PlantaBaixa/saida_planta_baixa.mp3")
var PLANTABAIXA = preload("res://Audio/AudioInclusive/PlantaBaixa/planta_baixa_environment.mp3")

var SOUNDARRAY = [LAB257, PATIO, LAB152, LAB251, SALASERGIO, COPA, NRC, SECRETARIA, SAIDA]



onready var labelNomeSala = $LabelNomeSalas
onready var salasControl = $Salas

func _ready():
	AudioPlayer.stop_all_audios_bus("MenuSpeech")
	AudioPlayer.play_one_shot(PLANTABAIXA , "MenuSpeech") 
	labelNomeSala.text = ""
	selected_sala_index = 0
	
	salas = salasControl.get_children()
	for i in range(salas.size()):
		salas[i].connect("mouse_entered", self, "on_sala_mouse_entered", [i])
		salas[i].connect("mouse_exited", self, "on_sala_mouse_exited")
		
func on_sala_mouse_entered(index):
	labelNomeSala.text = salas[index].nome
	
func on_sala_mouse_exited():
	labelNomeSala.text = ""

func _input(event):
	if event is InputEventKey and event.is_pressed():
		if event.scancode == KEY_TAB:
			if selected_sala_index < salas.size() - 1:
				selected_sala_index += 1

				AudioPlayer.stop_all_audios_bus("MenuSpeech")
				AudioPlayer.play_one_shot(SOUNDARRAY[selected_sala_index] , "MenuSpeech") 
			else:
				selected_sala_index = 0
				AudioPlayer.stop_all_audios_bus("MenuSpeech")
				AudioPlayer.play_one_shot(SOUNDARRAY[selected_sala_index] , "MenuSpeech") 
			
		elif event.scancode == KEY_ENTER:
			salas[selected_sala_index].handle_emulated_input()

