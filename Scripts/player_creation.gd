extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var citizens: Array
	
	var num_people = Controller.num_people
	var edu_prob = Controller.edu_prob
	var imm_probs = generateSkewedProbabilities(num_people, 0.05, 0.70, 0.30)
	var names = load_json_file("res://Data/citizen_names.json").names
	
	names.shuffle()
	
	for i in range(num_people):
		var cit = Citizen.new(names[i], imm_probs[i], edu_prob)
		citizens.append(cit)	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generateSkewedProbabilities(count: int, minimum: float, maximum: float, average: float) -> Array:
	var probabilities = []
	
	for i in range(count):
		var value = randf() * (maximum - minimum) + minimum
		probabilities.append(value)
		
	return probabilities

func load_json_file(filePath: String):
	var file = FileAccess.open(filePath, FileAccess.READ)
	
	var json_data = file.get_as_text()
	var parsed_data = JSON.parse_string(json_data)
	
	return parsed_data
	
