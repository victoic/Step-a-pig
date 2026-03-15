extends Node

var file_path: String = "user://stats.cfg"

var config: ConfigFile = ConfigFile.new()
var config_err: Error
const pw: String = 'e2706c950d2143932629b17c97cae046fde49f0bdfdef9f7b921fcd34b6f5988'
var num_pigs: int = 0
var has_won: bool = false

func _ready() -> void:
	if FileAccess.file_exists(file_path):
		load_config()
	else:
		set_config()

func get_value(section, key) -> Variant:
	if config_err == OK:
		return config.get_value(section, key)
	return 0

func set_config(np: int = 0, hw: bool = false) -> void:
	if config_err == OK:
		config.set_value('stats', 'num_pigs', np)
		config.set_value('stats', 'has_won', hw)

func save_config(is_win: bool) -> void:
	if config_err == OK:
		has_won = is_win
		set_config(num_pigs, has_won)
		config.save_encrypted_pass(file_path, pw)
		print("NUM PIGS: {0} | HAS WON: {1}".format([num_pigs, has_won	]))

func load_config():
	config_err = config.load_encrypted_pass(file_path, pw)
	if config_err == OK:
		num_pigs = get_value('stats', 'num_pigs')
		has_won = get_value('stats', 'has_won')
		print("NUM PIGS: {0} | HAS WON: {1}".format([num_pigs, has_won	]))
