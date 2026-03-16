class_name Global extends Node

var cur_level: String = "res://resources/levels/level_1.tres"
var locale_dict: Dictionary[int, String] = {
	-1: "automatic",
	0: "pt",
	1: "en"
}

func _ready() -> void:
	set_locale()

func set_locale(id: int = -1) -> void:
	if locale_dict[id] == "automatic":
		var preferred_language = OS.get_locale_language()
		TranslationServer.set_locale(preferred_language)
	else:
		TranslationServer.set_locale(locale_dict[id])
