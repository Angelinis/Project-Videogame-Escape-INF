extends Node2D

var current_wall_index := 0 setget set_current_wall

var selected_scene

var selected_hover_info

var total_number_hover_info

var index_hover_info := 0

# Connecting the readable script with the walls manager
#onready var readable_script = load("res://path_to_the_readable_script/ReadableScript.gd")

# Adding variable for the readable
#var is_open = false

onready var walls := get_children()

# Changing the open_state of a readable
#func _on_readable_open_changed(is_open_state):
#	is_open = is_open_state

func _ready():
	# Connecting the readable script with the walls manager
#	readable_script.connect("readable_open_changed", self, "_on_readable_open_changed")
	
	if ProgressManager.previous_wall_index != null:
		if walls.size() >= ProgressManager.previous_wall_index + 1:
			current_wall_index = ProgressManager.previous_wall_index
	
	# Esconde todas as walls e mostra a primeira atual
	for wall in walls:
		wall.hide()
	walls[current_wall_index].show()
	
	selected_scene = walls[current_wall_index]
	total_number_hover_info = selected_scene.get_node("HoverInfos").get_child_count()

		
func _input(event):
	if event is InputEventKey:
				
#		if is_open:
#			return  # You can add additional handling or just leave it empty
#		else:
			if event.scancode == KEY_TAB and event.pressed:
				selected_hover_info = selected_scene.get_node("HoverInfos").get_child(index_hover_info)
				if selected_hover_info.audio:
					AudioPlayer.stop_all_audios_bus("MenuSpeech")
					AudioPlayer.play_one_shot(selected_hover_info.audio, "MenuSpeech") 
				if index_hover_info == (total_number_hover_info-1):
					index_hover_info = 0
				else: 
					index_hover_info += 1

					
					
			elif event.pressed and event.scancode == KEY_ENTER:
				if selected_hover_info:
					var path_info = selected_hover_info.bottom_area_path
					if path_info=="":
						return					
					var bottom_area = selected_scene.get_node(path_info)
		# Check if the bottom_area exists and has the handle_emulated_input function
					if bottom_area and bottom_area.has_method("handle_emulated_input"):
						# Manually create a custom InputEventMouseButton event to trigger the handle_emulated_input function
						var custom_event = InputEventMouseButton.new()
						custom_event.button_index = BUTTON_LEFT
						custom_event.pressed = true
						custom_event.position = Vector2.ZERO
						# Call the handle_emulated_input function in the bottom script and pass the custom event
						bottom_area.handle_emulated_input(custom_event)


func set_current_wall(wall_index):
	
	walls[current_wall_index].hide() # Esconde a wall anterior
	
	if wall_index < 0:
		wall_index = walls.size() - 1 # Vai para a ultima wall
	elif wall_index > walls.size() - 1:
		wall_index = 0 # Vai para a primeira wall
	
	current_wall_index = wall_index # Muda a wall atual

	selected_scene = walls[current_wall_index]
	total_number_hover_info = selected_scene.get_node("HoverInfos").get_child_count()
	index_hover_info = 0
	
	walls[current_wall_index].show() # Mostra a wall atual
