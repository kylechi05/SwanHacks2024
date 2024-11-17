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
			Controller.available_bed = randi_range(1, 4)
			Controller.available_vax = randi_range(2, 9)
			Controller.available_mask = randi_range(10, 50)
			Controller.available_post = randi_range(10, 50)
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
		
		if inf.getCurrentSickLength() >= inf.getTotalSickLength():
			var prob_dead = 0.5 # fatality rate
			if inf.getHospitalized():
				prob_dead *= (1 - 0.8) # 0.8 is survival increase for being in hospital
				Controller.beds_used -= 1
				
			if randf() < prob_dead:
				inf.setDead(true)
				Controller.dead.append(inf.getName())
			else:
				inf.setInfected(false)
				hold_uninf.append(inf)
				for i in range(Controller.citizenSprites.size()):
					if Controller.citizenSprites[i][0].name == inf.getName():
						if inf.getVaccinated():
							Controller.citizenSprites[i][0].texture = Controller.vaxTexture
						else:
							Controller.citizenSprites[i][0].texture = Controller.guyTexture
						break
			hold_inf.erase(inf)
		else:	
			inf.setCurrentSickLength(inf.getCurrentSickLength() + 0.5)
		
		if duringDay:
			loc = inf.getWork()
			for citizen in work[loc]:
				if citizen.getName() != inf.getName() and not citizen.getInfected() and randf() < 1 - citizen.getImmunity():
					citizen.setInfected(true)
					hold_uninf.erase(citizen)
					hold_inf.append(citizen)
					Controller.hospital_queue.append(citizen)
					for i in range(Controller.citizenSprites.size()):
						if Controller.citizenSprites[i][0].name == citizen.getName():
							Controller.citizenSprites[i][0].texture = Controller.sickTexture
							break
		else:
			loc = inf.getHome()
			for citizen in home[loc]:
				if citizen.getName() != inf.getName() and not citizen.getInfected() and randf() < 0.05 * (1 - citizen.getImmunity()):
					citizen.setInfected(true)
					hold_uninf.erase(citizen)
					hold_inf.append(citizen)
					Controller.hospital_queue.append(citizen)
					for i in range(Controller.citizenSprites.size()):
						if Controller.citizenSprites[i][0].name == citizen.getName():
							Controller.citizenSprites[i][0].texture = Controller.sickTexture
							break
					
		
			
	while Controller.beds_used < Controller.beds_total and Controller.hospital_queue:
		var citizen = Controller.hospital_queue.pop_front()
		if citizen.getDead() or not citizen.getInfected():
			continue
		citizen.setHospitalized(true)
		Controller.beds_used += 1

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
