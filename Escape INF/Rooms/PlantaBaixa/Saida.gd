extends Node2D

export(String, FILE, "*.tscn") var goto

const AUDIO_1 = preload("res://Audio/AudioInclusive/Saida/speech/speech_saida_1.mp3")
const AUDIO_2 = preload("res://Audio/AudioInclusive/Saida/speech/speech_saida_2.mp3")
const AUDIO_3 = preload("res://Audio/AudioInclusive/Saida/speech/speech_saida_3.mp3")

var intro_texts = [
	"Aqui está a saída do INF. Tão perto, e tão longe ao mesmo tempo.",
	"O vidro é blindado, me parece inútil tentar quebra na força bruta.",
	"Minha melhor chance é nessa fechadura eletrônica."
]

var intro_audios = [
	AUDIO_1,
	AUDIO_2,
	AUDIO_3
]

func _on_GoBack_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var _a = get_tree().change_scene(goto)
	
func _ready():
	
	var room_file = get_tree().current_scene.filename
	
	Input.set_default_cursor_shape(0)
	
	if not ProgressManager.check_progress("seen_texts", room_file, null, "intro_texts"):
		if not ProgressManager.check_progress("completed_puzzles", "res://Rooms/SalaNRC/Walls/SalaNRC.tscn", "SalaNRC_Wall2", "res://Interactables/Puzzles/SuperComputer/SuperC.tscn"):
			TextBox.show_texts(intro_texts, intro_audios)
			ProgressManager.add_seen_texts(room_file, "intro_texts")
