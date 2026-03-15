class_name LevelData extends Resource

const PIG_DICTIONARY: Dictionary[String, String] = {
	'-': "res://scenes/pig/none.tscn",
	'0': "res://scenes/pig/pigtrician.tscn",
	'1': "res://scenes/pig/porcus.tscn",
	'2': "res://scenes/pig/porc.tscn",
	'3': "res://scenes/pig/cochonvalier.tscn",
	'4': "res://scenes/pig/pig.tscn",
	'5': "res://scenes/pig/swine.tscn",
	'6': "res://scenes/pig/snipig.tscn",
}

@export var map: String = '000000000000000000000000|------------------------|000000000000000000000000|------------------------|111111111111111111111111'
@export var bg: String = "res://assets/backgrounds/bg-level1.png"
@export var life_icon: String = "res://assets/icons/plebs.png"
@export var next_level: String = "res://resources/levels/level_2.tres"
@export var phrase: String = "Até hoje, a história de todas as sociedades é a história das lutas de classes."
@export var location_date: String = "Roma, 287 AC"
@export var play_music_1: bool = true
@export var play_music_2: bool = false
@export var play_music_3: bool = false
@export var is_ending: bool = false

func load_map() -> Array[Array]:
	var scenes: Array[Array] = []
	for row: String in map.split('|'):
		scenes.append([])
		for char: String in row:
			if char in PIG_DICTIONARY:
				scenes[-1].append(load(PIG_DICTIONARY[char]))
	return scenes
