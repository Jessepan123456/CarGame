extends Node

@onready var static_body: StaticBody2D = $StaticBody2D
@onready var block: Sprite2D = $Block

func _process(_delta):
	if GlobalGameSignal.Block == false:
		block.visible = false
		static_body.collision_layer = 0
	else:
		block.visible = true
		static_body.collision_layer = 2
