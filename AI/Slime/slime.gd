extends Node2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var cast_right: RayCast2D = $RayCastRight
@onready var cast_left: RayCast2D = $RayCastLeft

@export var SPEED = 60

var direction = 1

##help detected when the ray case touch something
func _process(delta: float) -> void:
	if cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta
