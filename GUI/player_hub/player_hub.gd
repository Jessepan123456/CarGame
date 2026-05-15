extends CanvasLayer

signal reach_lap

var hearts : Array[ HeartGUI ] = []
var speed_bar : Array[ SpeedGUI ] = []
var time : int
var j : int = 0
var totals : int

@onready var timer: Label = $Control/Timer
@onready var control: Control = $Control
@onready var lap_num: Label = $Control/LapTime
@onready var laps: Label = $Control/Laps

func _ready() -> void:
	#Hides the hearts
	for child in $Control/HFlowContainer.get_children():
		if child is HeartGUI: 
			hearts.append( child )
			child.visible = false
	#Hides the speedbar
	for child in $Control/HFlowContainer2.get_children():
		if child is SpeedGUI: #See if it a speedbar and make it not visible
			speed_bar.append( child )
			child.visible = false
	
## Calculate how many heart the player has
func update_hp( _hp : int, _max_hp : int ) -> void:
	update_max_hp( _max_hp )
	for i in hearts.size():
		update_heart( i, _hp )
	pass
	
## Updates the value of heart the player has
func update_heart( _index : int, _hp : int) -> void:
	var _value : int = clampi( _hp - _index * 2, 0, 2)
	hearts[ _index ].value = _value
	pass

## Displays the right amount of hearts
func update_max_hp( _max_hp : int ) -> void:
	var _heart_count : int = roundi( _max_hp * 0.5 )
	for i in hearts.size():
		if i < _heart_count:
			hearts[i].visible = true
		else:
			hearts[i].visible = false
	pass
	
## Get the amount of speed it should be displayed
func update_bar( energy : float, _max_energy : float ) -> void:
	for i in speed_bar.size():
		update_speedbar( i, energy)
	pass

## Display that amount in frames
func update_speedbar( index : float, energy : float) -> void:
	var _value : float = clampi((energy/5) - index, 0, 12)
	speed_bar[index].value = _value
	speed_bar[index].visible = true 
	
##Display the timer 
func update_timer( num : int ) -> void:
	time = num
	timer.text = str(num)
	pass
	
## Return the time
func get_timer() -> int:
	return time
	
## Display time for each lap finished
func lap_time( l : String ) -> void:
	lap_num.text = l
	lap_num.modulate.a = 1.0 
	
	#Slowly turn the modulate down
	var tween = create_tween()
	tween.tween_property(lap_num, "modulate:a", 0.0, 2.0)
	reach_lap.emit()
	pass
	
## Display the needed laps
func total_lap( total : int ) -> void:
	totals = total
	if j < total:
		j += 1
		laps.text = str(j) + "/" + str(total)
	pass
	
func reset() -> void:
	j = 0
	laps.text = str(j) + "/" + str(totals)
	
## Hides the hub
func hide_player_hub() -> void:
	control.visible = false
	pass

## Show the hub
func show_player_hub() -> void:
	control.visible = true
	pass
