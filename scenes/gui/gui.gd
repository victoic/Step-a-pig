class_name GUI extends Control

@onready var label: Label = $Label
@onready var life1: TextureRect = $PanelContainer/HBoxContainer/Life1
@onready var life2: TextureRect = $PanelContainer/HBoxContainer/Life2
@onready var life3: TextureRect = $PanelContainer/HBoxContainer/Life3

func change_lives(lives: int) -> void:
	if lives == 3:
		life3.visible = true
		life2.visible = true
		life1.visible = true
	elif lives == 2:
		life3.visible = false
		life2.visible = true
		life1.visible = true
	elif lives == 1:
		life3.visible = false
		life2.visible = false
		life1.visible = true
	else:
		life3.visible = false
		life2.visible = false
		life1.visible = false
