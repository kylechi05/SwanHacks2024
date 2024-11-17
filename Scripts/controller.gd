extends Node

var num_people = 80
var edu_prob = 0.3
var imm_prob_window = {"min": 0.45, "max": 0.80}
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
var POST_COST = 100
var MASK_COST = 20

var get_money = true
var total_money = 0

var brightness = 0

var beds_bought = 0
var vaccines_bought = 0
var posters_bought = 0
var masks_bought = 0

var available_post = 0
var available_mask = 0
var available_bed = 0
var available_vax = 0

var beds_total = 0
var beds_used = 0
var vaccines_total = 0
var vaccines_used = 0
var posters_total = 0
var masks_total = 0
var masks_used = 0

var places = {}
var tile_array_0 = []
var collision_data = []
var astar_ley = {}
var citizen_astar = AStar2D.new()

var calc_start = false
var calc_noon = false
var calc_night = false
var home_populations = {}
var work_populations = {}
var infected = []
var uninfected = []
var dead = []
var hospital_queue = []

var citizenSprites = []
var sickTexture = load("res://Sprites/guysick.png")
var vaxTexture = load("res://Sprites/guyvax.png")
var guyTexture = load("res://Sprites/guy.png")

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

func start():
	get_tree().change_scene_to_file("res://Scenes/instruct.tscn")

func go_map():
	get_tree().change_scene_to_file("res://Scenes/map.tscn")
	

func next_day():
	Controller.beds_total += beds_bought
	Controller.masks_total += masks_bought
	Controller.posters_total += posters_bought
	Controller.vaccines_total += vaccines_bought
	vaccines_bought = 0
	posters_bought = 0
	masks_bought = 0
	beds_bought = 0
	Controller.total_money += Controller.MONEY_PER_DAY
	get_money = true
	Controller.current_day += 1
	Controller.TIME_OF_DAY = -3
	Controller.calc_start = false
	Controller.calc_night = false
	Controller.calc_noon = false
	for i in range(citizenSprites.size()):
		var sprite = citizenSprites[i][0]
		var script = citizenSprites[i][1]
		sprite.script = null
		sprite.set_script(script)

func vax():
	if Controller.total_money - Controller.VAX_COST >= 0 and Controller.available_vax > 0: 
		Controller.vaccines_bought += 1
		Controller.available_vax -= 1
		Controller.total_money -= Controller.VAX_COST

func post():
	if Controller.total_money - Controller.POST_COST >= 0 and Controller.available_post > 0: 
		Controller.posters_bought += 1
		Controller.available_post -= 1
		Controller.total_money -= Controller.POST_COST

func mask():
	if Controller.total_money - Controller.MASK_COST >= 0 and Controller.available_mask > 0: 
		Controller.masks_bought += 1
		Controller.available_mask -= 1
		Controller.total_money -= Controller.MASK_COST

func bed():
	if Controller.total_money - Controller.BED_COST >= 0 and Controller.available_bed > 0: 
		Controller.beds_bought += 1
		Controller.available_bed -= 1
		Controller.total_money -= Controller.BED_COST
	

func item_overlap(item_position, item_size, mouse_position):
	return item_position.x < mouse_position.x and mouse_position.x < (item_position.x + item_size.x) and item_position.y < mouse_position.y and mouse_position.y < (item_position.y + item_size.y)
