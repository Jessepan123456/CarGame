extends Node2D

const DeathMenu : String = "res://GUI/death_hub/DeathHub.tscn"

## Stores the scene
@export var road_scenes : Array[PackedScene]
@export var player : Node2D
@export var speed : int = 150

var segments = []

var segment_height = 640
var spawn_count = 5

func _ready() -> void:
	GlobalGameSignal.endless = true

	for i in range(spawn_count):

		var chosen_scene = road_scenes[randi() % road_scenes.size()]
		var segment = chosen_scene.instantiate()

		add_child(segment)

		segment.position.y = i * -segment_height

		segments.append(segment)

func _process(delta: float) -> void:
	#Spawn Continuing
	var first_segment = segments[0]
	
	for segment in segments:
		segment.position.y += speed * delta
	
	if first_segment.position.y > segment_height:
		recycle_segment()
	
	if player.global_position.y > 300:
		get_tree().change_scene_to_file(DeathMenu)
		
func recycle_segment() -> void:

	segments.pop_front()

	var last_segment = segments[-1]

	var chosen_scene = road_scenes[randi() % road_scenes.size()]
	var new_segment = chosen_scene.instantiate()

	new_segment.position.y = last_segment.position.y - segment_height

	add_child(new_segment)
	segments.append(new_segment)
