extends Control

var completed = false

onready var panels = get_children()

#onready var destinyButton = $TextureRect8

func _ready():
		TextBox.show_texts(["A chave para sair do laboratório!!"])
	#get_parent().complete()
		
