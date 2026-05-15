extends Node

@onready var sprite: Sprite2D = $"."

func _ready() -> void:
	sprite.visible = false
	# It never spawned
	if CarManager.player_spawned == false:
		CarManager.position( sprite.global_position )
	pass
