extends Node2D

@export var animation_type : int = 0
@onready var snow_amount: AnimationPlayer = $SnowAmount

func _ready() -> void:
	if animation_type == 0:
		snow_amount.play("snow1")
	if animation_type == 1:
		snow_amount.play("snow2")
	if animation_type == 2:
		snow_amount.play("snow3")
	if animation_type == 3:
		snow_amount.play("snow4")
