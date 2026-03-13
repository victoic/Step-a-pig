class_name LevelData extends Resource

const PIG_DICTIONARY: Dictionary[String, String] = {
	'-': "res://scenes/pig/none.tscn",
	'0': "res://scenes/pig/pig.tscn",
	'1': "res://scenes/pig/pigtrician.tscn"
}
@export var map_file: String = "res://assets/text/levels/level01.txt"
@export var bg: String = "res://assets/backgrounds/bg-level1.png"
@export var life_icon: String = "res://assets/icons/plebs.png"
@export var next_level: String = "res://resources/levels/level_2.tres"
@export var phrase: String = "Até hoje, a história de todas as sociedades é a história das lutas de classes."

func load_map() -> Array[Array]:
	var scenes: Array[Array] = []
	if FileAccess.file_exists(map_file):
		var file: FileAccess = FileAccess.open(map_file, FileAccess.READ)
		var map: PackedStringArray = file.get_as_text().split('\n')
		for row: String in map:
			scenes.append([])
			for char: String in row:
				if char in PIG_DICTIONARY:
					scenes[-1].append(load(PIG_DICTIONARY[char]))
	return scenes
