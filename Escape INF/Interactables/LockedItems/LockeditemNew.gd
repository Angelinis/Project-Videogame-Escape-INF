extends Area2D

export(String) var locked_name
export(bool) var locked := false

export(Resource) var item_needed

export(String, MULTILINE) var needed_text
export(String, MULTILINE) var used_text

export(String, FILE, "*.tscn") var goto

onready var sprite = $Sprite
var _hovering = false

func _ready():
	var room_file = get_tree().current_scene.filename
	var wall_name = get_parent().name
	
	if ProgressManager.check_progress("unlocked_items", room_file, wall_name, locked_name):
		locked = false
		if sprite.hframes > 1:
			sprite.frame = 1

func _on_Door_mouse_entered():
	_hovering = true

func _on_Door_mouse_exited():
	_hovering = false
	
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
			TextBox.show_texts([used_text])
			locked = false
			ProgressManager.add_unlocked_item(room_file, wall_name, locked_name)
			Inventory.remove_item(item_needed)
			if sprite.hframes > 1:
				sprite.frame = 1
			ProgressManager.anxiety -= 10
		else:
			TextBox.show_texts([needed_text])
	else:
		if goto:
			ProgressManager.previous_room = room_file
			ProgressManager.previous_wall_name = wall_name
			ProgressManager.previous_wall_index = wall_index
			var _a = get_tree().change_scene(goto)
