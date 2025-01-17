extends Control

const ITEM_PANEL = preload("res://Interface/InventoryRect/itemPanel.tres")
const SELECTED_ITEM_PANEL = preload("res://Interface/InventoryRect/selectedItemPanel.tres")

const BACKPACK_CLOSED = preload("res://Audio/AudioInclusive/UI/ui_backpack_closed.mp3")
const BACKPACK_OPEN = preload("res://Audio/AudioInclusive/UI/ui_backpack_open.mp3")
const SELECTED_ITEM = preload("res://Audio/AudioInclusive/Inventory/selected_item_sound.mp3")
const SELECTED_ITEM_2 = preload("res://Audio/AudioInclusive/Inventory/item_backpack_accessibility.mp3")

var simulated_index_hover_info := 0
var total_items

var hovering_slot_index = null
var selected_slot_index = null setget select_slot

var _hovering = false

onready var slotsGrid := $HBoxContainer/GridContainer
onready var itemDescription := $HBoxContainer/ItemDescription
onready var walls_manager = get_tree().get_current_scene().get_node("Walls")

signal selected_item_changed

#signal inventory_visibility_changed(visible)

func _ready():
	
	var _a = Inventory.connect("item_changed", self, "update_slot")
	
	for i in range(Inventory.inventory_size):
		var _b = slotsGrid.get_child(i).connect("gui_input", self, "slot_gui_input", [i])
		var _c = slotsGrid.get_child(i).connect("mouse_exited", self, "slot_mouse_exited")
		update_slot(i)

	self.selected_slot_index = Inventory.selected_item_index
	
func slot_gui_input(event, slot_index):
	if event is InputEventMouseMotion:
		hovering_slot_index = slot_index
		
func slot_mouse_exited():
	hovering_slot_index = null

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_M:
			var inventoryRect = get_parent() # Access the parent node directly
			if event.pressed and !inventoryRect.visible:
				inventoryRect.visible = true
				AudioPlayer.play_audio(BACKPACK_OPEN, "UISound")
				Blur.unfocus_blur()
				walls_manager.window_open = true
				
			elif event.pressed and inventoryRect.visible:
				inventoryRect.visible = false
				AudioPlayer.stop_all_audios_bus("MenuSpeech")
				AudioPlayer.play_audio(BACKPACK_CLOSED, "UISound")
				Blur.visible = false
				walls_manager.window_open = false
			#emit_signal("inventory_visibility_changed", inventoryRect.visible)  # Emit the signal
			
		if event.scancode == KEY_TAB:
			var inventoryRect = get_parent()
			total_items = auxiliar_count_NonNullValues(Inventory.items) 
			if event.pressed and inventoryRect.visible:
				AudioPlayer.stop_all_audios_bus("MenuSpeech")
				AudioPlayer.play_one_shot(Inventory.items[simulated_index_hover_info].audio, "MenuSpeech") 
				if simulated_index_hover_info + 1  == total_items:
					simulated_index_hover_info = 0
				else:
					simulated_index_hover_info += 1
					
		if event.scancode == KEY_ENTER:
			var inventoryRect = get_parent()
			if event.pressed and inventoryRect.visible:
				if simulated_index_hover_info == 0:
					selected_slot_index = total_items - 1
					select_slot(selected_slot_index)
					AudioPlayer.stop_all_audios_bus("UISound")
					AudioPlayer.stop_all_audios_bus("MenuSpeech")
					AudioPlayer.play_one_shot(SELECTED_ITEM, "UISound") 
					AudioPlayer.play_one_shot(SELECTED_ITEM_2, "MenuSpeech") 
				else:
					selected_slot_index = simulated_index_hover_info - 1
					select_slot(selected_slot_index)
					AudioPlayer.stop_all_audios_bus("UISound")
					AudioPlayer.stop_all_audios_bus("MenuSpeech")
					AudioPlayer.play_one_shot(SELECTED_ITEM, "UISound") 
					AudioPlayer.play_one_shot(SELECTED_ITEM_2, "MenuSpeech") 

				
			

						
	if event is InputEventMouseButton:
		
		if event.button_index == BUTTON_LEFT and event.pressed and hovering_slot_index != null:
			var item: Item = Inventory.items[hovering_slot_index]
			if item != null:
				if hovering_slot_index == selected_slot_index:
					self.selected_slot_index = null # Deselect
				else:
					self.selected_slot_index = hovering_slot_index # Select
	
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and get_parent().visible and not _hovering:
		get_parent().visible = false
		get_tree().set_input_as_handled()
		Blur.visible = false

func select_slot(slot_index):
	
	var old_selected_slot_index = selected_slot_index
	selected_slot_index = slot_index
	Inventory.selected_item_index = selected_slot_index
	emit_signal("selected_item_changed")
	
	if old_selected_slot_index != null:
		slotsGrid.get_child(old_selected_slot_index).set("custom_styles/panel", ITEM_PANEL)
	
	if selected_slot_index == null:
		itemDescription.update_selected_item(null)
	else:
		slotsGrid.get_child(selected_slot_index).set("custom_styles/panel", SELECTED_ITEM_PANEL)
		itemDescription.update_selected_item(Inventory.items[slot_index])
	
func update_slot(slot_index):
	var item: Item = Inventory.items[slot_index]
	
	if item != null:
		var item_rect = TextureRect.new()
		item_rect.expand = true
		item_rect.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		item_rect.texture = Inventory.items[slot_index].sprite
		item_rect.rect_min_size = Vector2(32,32)
		slotsGrid.get_child(slot_index).add_child(item_rect)
		slotsGrid.get_child(slot_index).mouse_default_cursor_shape = 2
		
	elif slotsGrid.get_child(slot_index).get_children().size() > 0:
		slotsGrid.get_child(slot_index).get_child(0).queue_free()
		slotsGrid.get_child(slot_index).mouse_default_cursor_shape = 0
		self.selected_slot_index = null

func _on_InventoryRect_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			get_parent().show()
			Blur.unfocus_blur()




func _on_InventoryRect_mouse_entered():
	_hovering = true

func _on_InventoryRect_mouse_exited():
	_hovering = false
	
func auxiliar_count_NonNullValues(arr: Array) -> int:
	var count = 0

	for value in arr:
		if value != null:
			count += 1

	return count	
