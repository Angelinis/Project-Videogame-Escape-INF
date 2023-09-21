extends Area2D

export (PackedScene) var readable_scene

#export (bool) var readable_opened = false

var readable_instance

var _hovering = false


func _on_ReadableArea_mouse_entered():
	_hovering = true
	Input.set_default_cursor_shape(2)
	
func _on_ReadableArea_mouse_exited():
	_hovering = false
	Input.set_default_cursor_shape(0)

func _input(event):
	if _hovering:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
			AudioPlayer.play_audio(preload("res://Audio/SFX/paper.wav"),"Sound")
			get_tree().get_current_scene().add_child(readable_scene.instance())
			get_tree().set_input_as_handled()


func handle_emulated_input():
#	if readable_opened == false:
#	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		AudioPlayer.play_audio(preload("res://Audio/SFX/paper.wav"), "Sound")
		readable_instance = readable_scene.instance()
		
		get_tree().get_current_scene().add_child(readable_instance)
		get_tree().set_input_as_handled()
		
		
#	elif readable_opened == true: 
#		AudioPlayer.play_audio(preload("res://Audio/SFX/paper.wav"), "Sound")
#		readable_instance.queue_free()
#		Blur.visible = false
#		readable_opened = false
