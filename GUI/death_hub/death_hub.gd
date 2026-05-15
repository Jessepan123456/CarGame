extends CanvasLayer

const Menu : String = "res://GUI/start_hub/start_menu.tscn"

@onready var menu: Button = $Control/Menu

func _ready() -> void:
	menu.pressed.connect( back_menu )
	pass
	
func back_menu() -> void:
	get_tree().change_scene_to_file( Menu )
