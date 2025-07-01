extends Node3D

@export var speed : float = 10.0
@export var max_distance : float = 30.0
var start_pos : Vector3


func _ready() -> void:
	start_pos = position
	
	
func _process(delta: float) -> void:
	translate(basis.z * speed * delta)
	
	if position.distance_to(start_pos) > max_distance:
		position = start_pos
