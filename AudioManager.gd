extends Node


@onready var window : Panel = get_node("AudioWindow")
@onready var master_slider : HSlider = get_node("AudioWindow/MasterVolumeSlider")
@onready var sfx_slider : HSlider = get_node("AudioWindow/SFXVolumeSlider")
@onready var music_slider : HSlider = get_node("AudioWindow/MusicVolumeSlider")

var master_index : int
var sfx_index : int
var music_index : int


func _ready() -> void:
	master_index = AudioServer.get_bus_index("Master")
	sfx_index = AudioServer.get_bus_index("SFX")
	music_index = AudioServer.get_bus_index("Music")

func _get_volume (bus_index : int) -> float:
	var db_volume = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(db_volume)
	
func _set_volume (bus_index : int, volume : float):
	var db_volume = linear_to_db(volume)
	AudioServer.set_bus_volume_db(bus_index, db_volume)
