extends Node

var file_path: String = "user://stats.cfg"

var config: ConfigFile = ConfigFile.new()
var config_err: Error
const pw: String = 'e2706c950d2143932629b17c97cae046fde49f0bdfdef9f7b921fcd34b6f5988'
var num_pigs: int = 0
var has_won: bool = false
var game_version: Dictionary = {
	"major": 1,
	"minor": 1,
	"patch": 0
}

func _ready() -> void:
	if FileAccess.file_exists(file_path):
		load_config()
	else:
		set_config()

func get_value(section: String, key: String, default = 0) -> Variant:
	if config_err == OK:
		var value: Variant = config.get_value(section, key, default)
		return value
	return default

func set_config(np: int = 0, hw: bool = false, gv: Dictionary = game_version) -> void:
	if config_err == OK:
		config.set_value('stats', 'num_pigs', np)
		config.set_value('stats', 'has_won', hw)
		config.set_value('stats', 'game_version', gv)

func save_config(is_win: bool) -> void:
	if config_err == OK:
		has_won = is_win
		set_config(num_pigs, has_won, game_version)
		config.save_encrypted_pass(file_path, pw)
		print("NUM PIGS: {0} | HAS WON: {1}".format([num_pigs, has_won	]))

func load_config():
	config_err = config.load_encrypted_pass(file_path, pw)
	if config_err == OK:
		num_pigs = get_value('stats', 'num_pigs')
		has_won = get_value('stats', 'has_won')
		game_version = get_value('stats', 'game_version', {"major": 1, "minor": 0, "patch": 3})
		if game_version["major"] < 1 and game_version["minor"] < 1:
			has_won = false
		print("NUM PIGS: {0} | HAS WON: {1} | GAME VERSION: {2}".format([num_pigs, has_won, game_version]))
