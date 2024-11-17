extends Node

var num_people = 80
var edu_prob = 0.3
var imm_prob_window = {"min": 0.05, "max": 0.70}
var MAP_SIZE = Vector2(44,30)
var CITIZEN_SPEED = 90;

var TOTAL_DAYS = 7
var current_day = 0

var reset_schedule = false

var TIME_OF_DAY = 0.0
var TIME_OF_MORN = 6.0
var TIME_OF_NIGHT = 18.0
var LENGTH_OF_DAY = 24
var MONEY_PER_DAY = 500
var VAX_COST = 250
var BED_COST = 1500
var POST_COST = 250
var MASK_COST = 20


var total_money = 0

var brightness = 0

var ui_y = -720

var beds_bought = 0
var vaccines_bought = 0
var posters_bought = 0
var masks_bought = 0

var places = {}
var tile_array_0 = []
var collision_data = []
var astar_ley = {}
var citizen_astar = AStar2D.new()

var tiles_currently_populated = []
var tile_content = []

func find_next_step(x, y, destination):
	var temp_vect = Vector2i(x/24, y/24)
	var next_step = Controller.places[temp_vect][0]
	var temp_path = citizen_astar.get_point_path(next_step, destination, false)
	if len(temp_path) < 2:
		return(null)
	return(temp_path[1])

func move_to_next_step(citizen, destination, time):
	citizen.global_position = (citizen.global_position.lerp(destination*24, time))

func isDay():
	return Controller.TIME_OF_DAY > Controller.TIME_OF_MORN and Controller.TIME_OF_DAY < Controller.TIME_OF_NIGHT

func next_day():
	Controller.current_day += 1
	Controller.TIME_OF_DAY = -3
	

func item_overlap(item_position, item_size, mouse_position):
	return item_position.x < mouse_position.x and mouse_position.x < (item_position.x + item_size.x) and item_position.y < mouse_position.y and mouse_position.y < (item_position.y + item_size.y)
