extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_json_file(filePath: String):
	var file = FileAccess.open(filePath, FileAccess.READ)
	
	var json_data = file.get_as_text()
	var parsed_data = JSON.parse_string(json_data)
	
	return parsed_data
	
func create_players():
	var citizens: Array
	
	var num_people = Controller.num_people
	var edu_prob = Controller.edu_prob
	var imm_prob_window = Controller.imm_prob_window
	var names = load_json_file("res://Data/citizen_names.json").names
	var places = Controller.places
	var houses: Array
	var work: Array
	var num_houses: int
	var num_work: int
	
	names.shuffle()
	
	for place in places.keys():
		var type = places[place][1]
		if type == 2:
			houses.append(place)
		elif type == 3:
			work.append(place)
		
	num_houses = houses.size()
	num_work = work.size()
	
	for i in range(num_people):
		var rand_house = houses[randi_range(0, num_houses - 1)]
		var rand_work = work[randi_range(0, num_work - 1)]
		
		var cit = Citizen.new(
			names[i],
			randomFloatInWindow(imm_prob_window["min"], imm_prob_window["max"]),
			randi_range(2, 7), edu_prob,
			rand_house,
			rand_work
		)
		citizens.append(cit)
		
		if rand_house in Controller.home_populations:
			Controller.home_populations[rand_house].append(cit)
		else:
			Controller.home_populations[rand_house] = [cit]
		Controller.uninfected.append(cit)
			
		if rand_work in Controller.work_populations:
			Controller.work_populations[rand_work].append(cit)
		else:
			Controller.work_populations[rand_work] = [cit]
			
		if i == num_people - 1:
			Controller.uninfected.erase(cit)
			Controller.infected.append(cit)
			
			cit.setInfected(true)
		
		
		var sprite = Sprite2D.new()
		var sprite_texture = load("res://Sprites/guy.png")
		var move_script = load("res://Scripts/test.gd")
		
		sprite.name = cit.getName()
		sprite.set_meta("object_reference", cit)
		sprite.texture = sprite_texture
		sprite.position = Vector2(cit.location[0] * 24, cit.location[1] * 24)
		sprite.set_script(move_script)
		add_child.call_deferred(sprite)

func randomFloatInWindow(minimum: float, maximum: float):
	return randf() * (maximum - minimum) + minimum


func _on_tile_map_finished_render() -> void:
	create_players()
