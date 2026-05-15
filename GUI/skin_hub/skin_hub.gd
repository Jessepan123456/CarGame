extends Node2D

const menu : String = "res://GUI/start_hub/start_menu.tscn"

@onready var back: Button = $CanvasLayer/Control/Back
@onready var skin_1: Button = $CanvasLayer/Control/Skin1
@onready var skin_2: Button = $CanvasLayer/Control/Skin2
@onready var skin_3: Button = $CanvasLayer/Control/Skin3

func _ready() -> void:
	back.pressed.connect( back_to_menu )
	
	#Skins
	skin_1.pressed.connect(set_skin1)
	skin_2.pressed.connect(set_skin2)
	skin_3.pressed.connect(set_skin3)
	
func set_skin1() -> void:
	GlobalGameSignal.skin_changed = 0
	
func set_skin2() -> void:
	GlobalGameSignal.skin_changed = 1
	
func set_skin3() -> void:
	GlobalGameSignal.skin_changed = 2
	
	
func back_to_menu() -> void:
	get_tree().change_scene_to_file(menu)
