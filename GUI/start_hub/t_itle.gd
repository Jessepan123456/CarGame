extends Sprite2D

@onready var title_animation: AnimationPlayer = $"../../../Title"

func _ready() -> void:
	title_animation.play("Title")
