class_name GUI extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label
@onready var phrase: Label = $Phrase
@onready var life1: TextureRect = $PanelContainer/HBoxContainer/Life1
@onready var life2: TextureRect = $PanelContainer/HBoxContainer/Life2
@onready var life3: TextureRect = $PanelContainer/HBoxContainer/Life3
@onready var victory_panel: Panel = $VictoryPanel
@onready var loss_panel: Panel = $LossPanel

func change_life_icon(path: String) -> void:
	life1.texture = load(path)
	life2.texture = load(path)
	life3.texture = load(path)

func set_phrase(text: String) -> void:
	phrase.text = text
	animation_player.play("start")

func show_victory_panel() -> void:
	victory_panel.visible = true

func show_loss_panel() -> void:
	loss_panel.visible = true

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
