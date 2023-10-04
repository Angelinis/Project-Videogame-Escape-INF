extends Area2D

const SPEECH_1 = preload("res://Audio/AudioInclusive/Interactable/Door/interactable_door_block_progress.mp3")

var _hovering = false

export(String, MULTILINE) var needed_text

func _on_BlockProgress_mouse_entered():
	_hovering = true
	Input.set_default_cursor_shape(2)

func _on_BlockProgress_mouse_exited():
	_hovering = false
	Input.set_default_cursor_shape(0)

func handle_emulated_input():
	if needed_text == "Não consigo ver a fechadura com a luz apagada.":
		TextBox.show_texts([needed_text],[SPEECH_1])
	else:	
		TextBox.show_texts([needed_text])
	get_tree().set_input_as_handled()

func _input(event):
	if _hovering:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
			if needed_text == "Não consigo ver a fechadura com a luz apagada.":
				TextBox.show_texts([needed_text],[SPEECH_1])
			else:	
				TextBox.show_texts([needed_text])
			get_tree().set_input_as_handled()
