extends Sprite2D

@onready var car_animation: AnimationPlayer = $"../CarAnimation"

func _ready() -> void:
	car_animation.play("Car")
