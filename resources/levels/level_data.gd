class_name LevelData extends Resource

const PIG_DICTIONARY: Dictionary[String, String] = {
	'0': "res://scenes/pig/pig.tscn"
}
@export var map_file: String = "res://assets/text/levels/level01.txt"

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
