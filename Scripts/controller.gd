extends Node

var MAP_SIZE = Vector2(44,30)
var CITIZEN_SPEED = 1.0;


var places = {}
var tile_array_0 = []
var num_people = 40
var collision_data = []
var astar_ley = {}
var citizen_astar = AStar2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
<<<<<<< Updated upstream
 pass
=======
	pass

func find_next_step(x, y, destination):
	var temp_vect = Vector2i(x/24, y/24)
	var next_step = Controller.places[temp_vect][0]
	var temp_path = citizen_astar.get_point_path(next_step, destination, false)
	print(temp_path)
	if len(temp_path) < 2:
		return(null)
	return(temp_path[1])

func move_to_next_step(citizen, destination, time):
	citizen.global_position = (citizen.global_position.lerp(destination*24, time))
>>>>>>> Stashed changes
