extends Node2D

export(String, FILE, "*.tscn") var goto

const AUDIO_1 = preload("res://Audio/AudioInclusive/Patio/speech/speech_patio_1.mp3")
const AUDIO_2 = preload("res://Audio/AudioInclusive/Patio/speech/speech_patio_2.mp3")
const AUDIO_3 = preload("res://Audio/AudioInclusive/Patio/speech/speech_patio_3.mp3")

var intro_texts = [
	"Que pena, fecharam a passagem por conta do telhado que foi danificado.",
	"Não há nada nesse ambiente que me ajude a sair daqui.",
	"Melhor continuar minha jornada, tenho que chegar o tempo do churrasco."
]

var audio_texts = [
	AUDIO_1,
	AUDIO_2,
	AUDIO_3
]


func _on_GoBack_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var _a = get_tree().change_scene(goto)
	
func _ready():
	
	var room_file = get_tree().current_scene.filename
	
	if not ProgressManager.check_progress("seen_texts", room_file, null, "intro_texts"):
		TextBox.show_texts(intro_texts, audio_texts)
		ProgressManager.add_seen_texts(room_file, "intro_texts")
