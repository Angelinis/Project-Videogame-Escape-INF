extends CanvasLayer

export (float) var time := 0.05

const CHAR_AUDIO = preload("res://Interface/TextBox/CharSFX.wav")
const PROCCEED_AUDIO = preload("res://Interface/TextBox/ProcceedSFX.wav")

var texts: Array
var audios: Array
var text_count = 0
var showing:= true

var done := true setget setDone

signal texts_done

onready var icon = $Control/TextBox/TextureRect
onready var timer = $Control/TextBox/Timer
onready var textLabel = $Control/TextBox/Text

func show_texts(_texts, _audios=[]):
	show()
	texts = _texts
	audios = _audios
	text_count = 0
	if _audios==[]: 
		_show_text(texts[text_count])
	else: 
		_show_text(texts[text_count], audios[text_count])


func _show_text(_text, _audio = false):
	self.done = false
	showing = true
	icon.hide()
	
	textLabel.text = _text
	textLabel.visible_characters = 0
	timer.start(time)
	if (_audio):
		AudioPlayer.stop_all_audios_bus("CharacterSpeech")
		AudioPlayer.play_audios([_audio, PROCCEED_AUDIO], "CharacterSpeech")
#		AudioPlayer.play_audio(_audio, "CharacterSpeech")


func _input(event):
	if visible:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				get_tree().set_input_as_handled()
				if not done:
					self.done = true
				elif done:
					if text_count < texts.size() - 1:
						text_count += 1
						if audios:
							_show_text(texts[text_count],audios[text_count])
						else: 
							_show_text(texts[text_count])
							
					else:
						hide()
						AudioPlayer.play_audio(PROCCEED_AUDIO, "Sound")
						emit_signal("texts_done")
						

#Adding Input Listener for Enter to Change Text						
						
						
		elif event is InputEventKey:
			if event.scancode == KEY_ENTER and event.pressed:
				get_tree().set_input_as_handled()
				if not done:
					self.done = true
				elif done:
					#Stops the CharacterSpeech when pressing ENTER
					AudioPlayer.stop_all_audios_bus("CharacterSpeech")
					
					if text_count < texts.size() - 1:
						text_count += 1
						if audios:
							_show_text(texts[text_count],audios[text_count])
						else: 
							_show_text(texts[text_count])
					else:
						hide()
						showing = false
#						AudioPlayer.play_audio(PROCCEED_AUDIO, "Sound")
						emit_signal("texts_done")
						

func _on_Timer_timeout():
	if not done:
		textLabel.visible_characters += 1
		# AudioPlayer.play_audio(CHAR_AUDIO, "Sound")
		if textLabel.visible_characters == textLabel.get_total_character_count():
			self.done = true
#			AudioPlayer.play_audio(PROCCEED_AUDIO, "Sound")

func setDone(value):
	done = value
	if done:
		textLabel.visible_characters = textLabel.get_total_character_count()
		icon.show()
		
func isTextShowing():
	return showing
