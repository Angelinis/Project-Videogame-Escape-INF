extends Control

export (String, FILE, "*.tscn") var first_room

const SPEECH_1 = preload("res://Audio/AudioInclusive/Intro/intro_speech_part1.mp3")
const SPEECH_2 = preload("res://Audio/AudioInclusive/Intro/intro_speech_part2.mp3")
const SPEECH_3 = preload("res://Audio/AudioInclusive/Intro/intro_speech_part3.mp3")
const SPEECH_4 = preload("res://Audio/AudioInclusive/Intro/intro_speech_part4.mp3")
const SPEECH_5 = preload("res://Audio/AudioInclusive/Intro/intro_speech_part5.mp3")

var texts = [
	"Zzz...",
	"...",
	"!!!",
	"Acho que dormi demais!",
	"Preciso sair daqui..."
]

var audios = [
	SPEECH_1,
	SPEECH_2,
	SPEECH_3,
	SPEECH_4,
	SPEECH_5
]

func _ready():
	
	var _a = TextBox.connect("texts_done", self, "_on_texts_done")
	
	yield(get_tree().create_timer(1), "timeout") # Espera 1 segundo
	TextBox.show_texts(texts, audios)
	
func _on_texts_done():
	yield(get_tree().create_timer(1), "timeout") # Espera 1 segundo
	SceneTransition.transition_scene(first_room)
