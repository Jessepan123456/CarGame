extends Node2D

@export var animation_tree: AnimationTree
@onready var player : Racing_Car = get_owner()

var last_facing_direction := Vector2(0, -1)

func _physics_process(delta: float) -> void:
	
	var idle = !player.velocity
	
	if player.speed_up:
		animation_tree.set("parameters/SpeedUp/blend_position", last_facing_direction)
	
	if !idle:
		last_facing_direction = player.velocity.normalized()
	
	animation_tree.set("parameters/Drive/blend_position", last_facing_direction)
	animation_tree.set("parameters/Idle/blend_position", last_facing_direction)
