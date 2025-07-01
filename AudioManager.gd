extends Node


@onready var window : Panel = get_node("AudioWindow")
@onready var master_slider : HSlider = get_node("AudioWindow/MasterVolumeSlider")
@onready var sfx_slider : HSlider = get_node("AudioWindow/SFXVolumeSlider")
@onready var music_slider : HSlider = get_node("AudioWindow/MusicVolumeSlider")

var master_index : int
var sfx_index : int
var music_index : int


func _ready() -> void:
	window.visible = false
	master_index = AudioServer.get_bus_index("Master")
	sfx_index = AudioServer.get_bus_index("SFX")
	music_index = AudioServer.get_bus_index("Music")
	
	master_slider.value = _get_volume(master_index)
	sfx_slider.value = _get_volume(sfx_index)
	music_slider.value = _get_volume(music_index)

	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		window.visible = !window.visible
		
		if window.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _get_volume (bus_index : int) -> float:
	var db_volume = AudioServer.get_bus_volume_db(bus_index)
	return db_to_linear(db_volume)
	
func _set_volume (bus_index : int, volume : float):
	var db_volume = linear_to_db(volume)
	AudioServer.set_bus_volume_db(bus_index, db_volume)
	
	


func _on_master_volume_slider_value_changed(value: float) -> void:
	_set_volume(master_index, value)
func _on_sfx_volume_slider_value_changed(value: float) -> void:
	_set_volume(sfx_index, value)
func _on_music_volume_slider_value_changed(value: float) -> void:
	_set_volume(music_index, value)
