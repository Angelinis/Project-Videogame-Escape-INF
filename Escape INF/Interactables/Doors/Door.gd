extends Area2D

const SPEECH_1 = preload("res://Audio/AudioInclusive/Interactable/Door/interactable_door_closed.mp3")
const USED_COLLECTED_1 = preload("res://Audio/AudioInclusive/Interactable/Collectable/collected_item_used_part1.mp3")
const USED_COLLECTED_2 = preload("res://Audio/AudioInclusive/Interactable/Collectable/collected_item_used_door_part2.mp3")

export(bool) var locked := false

export(Resource) var item_needed

export(String, FILE, "*.tscn") var goto

var _hovering = false

func handle_emulated_input():
		interact()
		get_tree().set_input_as_handled()
		

func _ready():
	var room_file = get_tree().current_scene.filename
	var wall_name = get_parent().name
	
	if ProgressManager.check_progress("unlocked_doors", room_file, wall_name):
		locked = false

func _on_Door_mouse_entered():
	_hovering = true
	Input.set_default_cursor_shape(2)

func _on_Door_mouse_exited():
	_hovering = false
	Input.set_default_cursor_shape(0)
	
func _input(event):
	if _hovering:
		if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
			interact()
			get_tree().set_input_as_handled()
		
func interact():
	
	var room_file = get_tree().current_scene.filename
	var wall_name = get_parent().name
	var wall_index = get_parent().get_parent().current_wall_index
	
	if locked:
		if Inventory.get_selected_item() == item_needed:
			TextBox.show_special_text("Você usou " + item_needed.name + " para destrancar a porta.", [USED_COLLECTED_1, item_needed.collected_audio , USED_COLLECTED_2])
			locked = false
			ProgressManager.add_unlocked_door(room_file, wall_name)
			AudioPlayer.play_audio(preload("res://Audio/SFX/door-unlock.wav"), "Sound")
			# Usar a chave do inventario
			Inventory.remove_item(item_needed)
			ProgressManager.anxiety -= 10
		else:
			TextBox.show_texts(["A porta está trancada."], [SPEECH_1])
			AudioPlayer.play_audio(preload("res://Audio/SFX/door-locked.wav"), "Sound")
	else:
		ProgressManager.previous_room = room_file
		ProgressManager.previous_wall_name = wall_name
		ProgressManager.previous_wall_index = wall_index
		var _a = get_tree().change_scene(goto)
