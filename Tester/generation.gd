extends Node2D

@export var noise_height_text : NoiseTexture2D
@onready var racetrack: TileMap = $Racetrack
var noise : Noise

var width : int = 400
var height : int = 400

var noise_val_arr = []

var source_id_land = 9
var source_id_water = 7
var water_atlas = Vector2(0,0)
var land_atlas = Vector2(2,1)

func _ready() -> void:
	noise = noise_height_text.noise
	generate_world()
	
func generate_world() -> void:
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val = noise.get_noise_2d(x, y)
			if noise_val >= 0.0:
				## place land
				racetrack.set_cell(0,Vector2(x,y), source_id_land, land_atlas)
				pass
			elif noise_val < 0.0:
				##place water
				racetrack.set_cell(0,Vector2(x,y), source_id_water, water_atlas)
				pass
			#print(noise_val)
			#noise_val_arr.append(noise_val)
			#
	##print("Highest", noise_val_arr.max())
	##print("Lowest", noise_val_arr.min())
