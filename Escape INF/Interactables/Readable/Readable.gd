extends Control

export (Array, String) var texts

export(Array, Resource) var audio

var _hovering = false

signal readable_opened_changed

var parent_scene

onready var walls_manager = get_tree().get_current_scene().get_node("Walls")

func _ready():
	get_parent().layer = 1
	Blur.unfocus_blur()
	if not audio.empty():
		TextBox.show_texts(texts, audio)
			
	elif not texts.empty():
		TextBox.show_texts(texts)	
		
func _process(delta):
	if TextBox.isTextShowing() == false:
		AudioPlayer.play_audio(preload("res://Audio/SFX/paper.wav"), "Sound")
		parent_scene.readable_opened = false
		queue_free()
		Blur.visible = false
		walls_manager.window_open = false


func _on_Content_mouse_entered():
	_hovering = true

func _on_Content_mouse_exited():
	_hovering = false

func _on_Readable_gui_input(event):
	if not _hovering:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
			queue_free()
			Blur.visible = false
