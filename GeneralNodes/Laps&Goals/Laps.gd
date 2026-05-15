class_name Laps extends Area2D

@onready var prevent_box: StaticBody2D = $StaticBody2D

@export var total_laps : int = 3
@export var level : int = 1

var count_laps : int 

##Detect if the player has made one lap
func _ready() -> void:
	count_laps = total_laps
	area_entered.connect( entered_lap )
	pass
	
##What to do when one lap is done
func entered_lap( _a: Area2D ) -> void:
	if count_laps != 0:
		var time : int = PlayerHub.get_timer()
		count_laps -= 1
		PlayerHub.lap_time(str(time))
		PlayerHub.total_lap((total_laps))
	prevent_box.collision_layer = 0
	await get_tree().create_timer(0.5).timeout 
	prevent_box.collision_layer = 2
	if count_laps == 0:
		FinishHub.show_finish_hub()
		if level == 1:
			GlobalGameSignal.Level01Day = true
		elif level == 2:
			GlobalGameSignal.Level01Night = true
		elif level == 3:
			GlobalGameSignal.Level02Day = true
	pass
	
