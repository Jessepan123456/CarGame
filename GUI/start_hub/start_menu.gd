class_name StartMenu extends Node

## Levels load
const START_LEVEL01 : String = "res://Levels/01/playground.tscn"
const START_LEVEL01N : String = "res://Levels/01N/Night01.tscn"
const START_LEVEL02N : String = "res://Levels/02N/Night02.tscn"
const START_LEVEL02 : String = "res://Levels/02/Day02.tscn"
const START_ENDLESS : String = "res://Levels/RoadGeneration/RoadManager.tscn"

const SKIN : String = "res://GUI/skin_hub/skin_hub.tscn"

## Button Levels
@onready var day_1: Button = $CanvasLayer/Control/Day1
@onready var night_1: Button = $CanvasLayer/Control/Night1
@onready var snow_day_2: Button = $CanvasLayer/Control/SnowDay2
@onready var rain_night_2: Button = $CanvasLayer/Control/RainNight2
@onready var endless: Button = $CanvasLayer/Control/Endless

## Locks
@onready var Night01Lock: Lock = $CanvasLayer/Locks/Lock
@onready var Day02Lock: Lock = $CanvasLayer/Locks/Lock2
@onready var Night02Lock: Lock = $CanvasLayer/Locks/Lock3
@onready var unlock: Button = $CanvasLayer/Control/Unlock

@onready var skins: Button = $CanvasLayer/Control/Skins

func _ready() -> void:
	PlayerHub.hide_player_hub()
	FinishHub.hide_finish_hub()
	day_1.pressed.connect( start_gameD1 )
	unlock.pressed.connect( unlockAll )
	
	# Next levels
	night_1.pressed.connect( start_game01N )
	rain_night_2.pressed.connect( start_game02N )
	snow_day_2.pressed.connect( start_game02D )
	endless.pressed.connect( start_endless )
	
	if GlobalGameSignal.Level01Day == true:
		Night01Lock.visible = false
	if GlobalGameSignal.Level01Night == true:
		Day02Lock.visible = false
	if GlobalGameSignal.Level02Day == true:
		Night02Lock.visible = false
	
	CarManager.can_control = false
	
	skins.pressed.connect( skin_selector )
	pass
	
func start_gameD1() -> void:
	GlobalGameSignal.Is_night = false
	get_tree().change_scene_to_file( START_LEVEL01 )
	PlayerHub.reset()
	PlayerHub.show_player_hub()
	CarManager.can_control = true
	
func start_game01N() -> void:
	if GlobalGameSignal.Level01Day == false:
		return
	GlobalGameSignal.Is_night = true
	get_tree().change_scene_to_file( START_LEVEL01N )
	PlayerHub.reset()
	PlayerHub.show_player_hub()
	CarManager.can_control = true
	
func start_game02N() -> void:
	if GlobalGameSignal.Level02Day == false:
		return
	GlobalGameSignal.Is_night = true
	get_tree().change_scene_to_file(START_LEVEL02N)	
	PlayerHub.reset()
	PlayerHub.show_player_hub()
	CarManager.can_control = true
	
func start_game02D() -> void:
	if GlobalGameSignal.Level01Night == false:
		return
	GlobalGameSignal.Is_night = false
	get_tree().change_scene_to_file(START_LEVEL02)	
	PlayerHub.reset()
	PlayerHub.show_player_hub()
	CarManager.can_control = true
	
func start_endless() -> void:
	GlobalGameSignal.Is_night = false
	get_tree().change_scene_to_file(START_ENDLESS)	
	PlayerHub.reset()
	PlayerHub.show_player_hub()
	CarManager.can_control = true

func unlockAll() -> void:
	$CanvasLayer/Locks/Lock.visible = false
	$CanvasLayer/Locks/Lock2.visible = false
	$CanvasLayer/Locks/Lock3.visible = false
	
	#Unlock All
	GlobalGameSignal.Level01Day = true
	GlobalGameSignal.Level01Night = true
	GlobalGameSignal.Level02Day = true
	
func skin_selector() -> void:
	get_tree().change_scene_to_file(SKIN)
