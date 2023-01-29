extends Control

func complete():
	
	var room_file = ProgressManager.previous_room
	var wall_name = ProgressManager.previous_wall_name

	ProgressManager.add_completed_puzzles(room_file, wall_name, filename)
	TextBox.show_texts(["Parece que funcionou."])
	print("LOG: Puzzle PassnumberNRC concluído.")
	ProgressManager.anxiety -= 25


func _on_TextureRect_gui_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		var _a = get_tree().change_scene(ProgressManager.previous_room)
