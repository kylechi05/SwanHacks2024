extends Node

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
		var cit = Citizen.new(
			names[i],
			randomFloatInWindow(imm_prob_window["min"], imm_prob_window["max"]),
			randi_range(2, 7), edu_prob,
			houses[randi_range(0, num_houses - 1)],
			work[randi_range(0, num_work - 1)]
		)
		citizens.append(cit)
		
func randomFloatInWindow(minimum: float, maximum: float):
	return randf() * (maximum - minimum) + minimum


func _on_tile_map_finished_render() -> void:
	create_players()
