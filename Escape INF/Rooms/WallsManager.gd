extends Node2D

var current_wall_index := 0 setget set_current_wall

var selected_scene

var selected_hover_info

var total_number_hover_info

var index_hover_info := 0

onready var walls := get_children()

func _ready():
	
	
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
		if event.scancode == KEY_TAB and event.pressed:
			selected_hover_info = selected_scene.get_node("HoverInfos").get_child(index_hover_info)
			if index_hover_info == (total_number_hover_info-1):
				index_hover_info = 0
			else: 
				index_hover_info += 1
			if selected_hover_info.audio:
				AudioPlayer.stop_all_audios_bus("MenuSpeech")
				AudioPlayer.play_one_shot(selected_hover_info.audio, "MenuSpeech") 


func set_current_wall(wall_index):
	
	walls[current_wall_index].hide() # Esconde a wall anterior
	
	if wall_index < 0:
		wall_index = walls.size() - 1 # Vai para a ultima wall
	elif wall_index > walls.size() - 1:
		wall_index = 0 # Vai para a primeira wall
	
	current_wall_index = wall_index # Muda a wall atual

	selected_scene = walls[current_wall_index]
	total_number_hover_info = selected_scene.get_node("HoverInfos").get_child_count()

	
	walls[current_wall_index].show() # Mostra a wall atual
