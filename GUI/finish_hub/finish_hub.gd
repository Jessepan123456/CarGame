extends CanvasLayer

const Menu : String = "res://GUI/start_hub/start_menu.tscn"

@onready var back: Button = $Control/Back

func _ready() -> void:
	$Control.visible = false
	back.pressed.connect( back_menu )
	pass
	
func back_menu() -> void:
	get_tree().change_scene_to_file( Menu )
	
func show_finish_hub() -> void:
	$Control.visible = true
	pass

func hide_finish_hub() -> void:
	$Control.visible = false
