class_name Menu extends Control

@onready var credits_panel: Panel = $Panel
@onready var star: TextureRect = $Star

func _ready() -> void:
	if Stats.has_won:
		star.visible = true

func _on_new_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/breakout/breakout.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_credits_button_pressed() -> void:
	credits_panel.visible = true
	
func _on_button_pressed() -> void:
	credits_panel.visible = false

func _on_option_button_item_selected(index: int) -> void:
	GameData.set_locale(index)
