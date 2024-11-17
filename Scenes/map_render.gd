extends TileMap

signal finished_render
var temp_color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	temp_color = 1
	var temp_file = FileAccess.open("res://GameData/map.txt", FileAccess.READ)
	var temp_string = temp_file.get_as_text().replace('\n', '')
	 	
	var i = 0
	var map_width = Controller.MAP_SIZE.x
	while i * map_width < temp_string.length():
		Controller.collision_data.append(temp_string.substr(i*map_width, map_width) )
		i += 1
	#Controller.collision_data.reverse()
	read_map()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	
	Controller.TIME_OF_DAY += delta
	if (Controller.isDay() and temp_color == 0.3):
		temp_color = 1
		self.set_modulate(Color(temp_color,temp_color,temp_color))
	elif (temp_color == 1 and !(Controller.isDay())):
		temp_color = 0.3
		self.set_modulate(Color(temp_color, temp_color, temp_color))
	
	if Controller.TIME_OF_DAY > 12 and not Controller.calc_noon:
		print(Controller.home_populations)
		print(Controller.work_populations)
		print("inf", Controller.infected)
		print("uninf", Controller.uninfected)
		print(" ")
		
		var change_infections = get_transmission_result(Controller.home_populations, Controller.work_populations, Controller.uninfected, Controller.infected, true)
		Controller.infected = change_infections["infected"]
		Controller.uninfected = change_infections["uninfected"]
		
		Controller.calc_noon = true
		
		print("inf", Controller.infected)
		print("uninf", Controller.uninfected)
		print(" ")

		
	if Controller.TIME_OF_DAY > 24 and not Controller.calc_night:
		if Controller.get_money == true:
			Controller.total_money += 500
			Controller.get_money = false
		var change_infections = get_transmission_result(Controller.home_populations, Controller.work_populations, Controller.uninfected, Controller.infected, false)
		Controller.infected = change_infections["infected"]
		Controller.uninfected = change_infections["uninfected"]
		
		Controller.calc_night = true
		
		print("inf", Controller.infected)
		print("uninf", Controller.uninfected)
		print(" ")
		
func get_transmission_result(home, work, uninfected, infected, duringDay):
	var hold_inf = infected
	var hold_uninf = uninfected
	
	for inf in infected:
		var loc
		
		if duringDay:
			loc = inf.getWork()
			for citizen in work[loc]:
				if citizen.getName() != inf.getName() and not citizen.getInfected() and randf() < 1- citizen.getImmunity():
					citizen.setInfected(true)
					citizen.setHospitalized(true)
					hold_uninf.erase(citizen)
					hold_inf.append(citizen)
		else:
			loc = inf.getHome()
			for citizen in home[loc]:
				if citizen.getName() != inf.getName() and not citizen.getInfected() and randf() < 1- citizen.getImmunity():
					citizen.setInfected(true)
					citizen.setHospitalized(true)
					hold_uninf.erase(citizen)
					hold_inf.append(citizen)

	return {
		"infected": hold_inf,
		"uninfected": hold_uninf,
	}
	
func read_map():
	var id = 0
	for x in range(len(Controller.collision_data)):
		for y in range(len(Controller.collision_data[x])):
			match Controller.collision_data[x][y]:
				#1 = road
				#2 = house
				#3 = workplace
				"0":
					var temp_int = randi() % 3
					match temp_int:
						0:
							set_cell(0, Vector2i(y,x), 0, Vector2i(0, 0))
						1:
							set_cell(0, Vector2i(y,x), 0, Vector2i(0, 8))
						2:
							set_cell(0, Vector2i(y,x), 0, Vector2i(0, 9))
				"r":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 1))
					Controller.places[Vector2i(y,x)] = [id, 1]
					Controller.citizen_astar.add_point(id,Vector2i(y,x))
					init_astar(x,y)
					id += 1
				"H":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 2))
					Controller.places[Vector2i(y,x)] = [id, 2]
					Controller.citizen_astar.add_point(id,Vector2i(y,x))
					init_astar(x,y)
					id += 1
				"h":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 3))
				"w":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 5))
				"i":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 7))
				"W":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 4))
					Controller.places[Vector2i(y,x)] = [id, 3]
					Controller.citizen_astar.add_point(id,Vector2i(y,x))
					init_astar(x,y)
					id += 1
				"I":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 6))
					Controller.places[Vector2i(y,x)] = [id, 4]
					print(id)
					Controller.citizen_astar.add_point(id,Vector2i(y,x))
					init_astar(x,y)
					id += 1
	finished_render.emit()

func init_astar(x, y):
		if x > 0:
			if Controller.places.has(Vector2i(y,x-1)):
				Controller.citizen_astar.connect_points(Controller.places[Vector2i(y,x-1)][0], Controller.places[Vector2i(y,x)][0], true)
		if y > 0:
			if Controller.places.has(Vector2i(y-1,x)):
				Controller.citizen_astar.connect_points(Controller.places[Vector2i(y-1,x)][0], Controller.places[Vector2i(y,x)][0], true)
