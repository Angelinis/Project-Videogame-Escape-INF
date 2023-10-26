extends Area2D

export(Resource) var item_data

const SFX = preload("res://Interactables/Collectable/CollectableSFX.wav")

const AUDIO_1 = preload("res://Audio/AudioInclusive/Interactable/Collectable/collected_item_part1.mp3")
const AUDIO_2 = preload("res://Audio/AudioInclusive/Interactable/Collectable/collected_item_part2.mp3")

var _hovering = false

onready var sprite := $Sprite

func _ready():
	
	var room_file = get_tree().current_scene.filename
	var wall_name = get_parent().name

	if ProgressManager.check_progress("collected_items", room_file, wall_name, item_data):
		queue_free()
		
func _on_Collectable_mouse_entered():
	_hovering = true
	Input.set_default_cursor_shape(2)

func _on_Collectable_mouse_exited():
	_hovering = false
	Input.set_default_cursor_shape(0)

func _input(event):
	if _hovering:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
			collect()
			get_tree().set_input_as_handled()

func handle_emulated_input():
	collect()
	get_tree().set_input_as_handled()

func collect():
		print("ITEM:" + item_data.name + " coletado!")
		
		TextBox.show_special_text("Você colocou " + item_data.name + " na sua mochila.", [AUDIO_1, item_data.collected_audio , AUDIO_2])
		
		Inventory.add_item(item_data)
	
		var room_file = get_tree().current_scene.filename
		var wall_name = get_parent().name
		ProgressManager.add_collected_item(room_file, wall_name, item_data)
	
		ProgressManager.anxiety -= 10
	
		AudioPlayer.play_audio(SFX, "Sound")
	
		queue_free()
