extends Node

# Import the Citizen class
class_name Citizen

# Function to initialize a Citizen object with attributes
func initialize_citizen(attributes: Dictionary) -> Citizen:
	var citizen = Citizen.new()
	if "name" in attributes:
		citizen.name = attributes["name"]
	if "immunity" in attributes:
		citizen.immunity = attributes["immunity"]
	if "isVaccinated" in attributes:
		citizen.setVaccinated(attributes["isVaccinated"])
	if "isMasked" in attributes:
		citizen.setMasked(attributes["isMasked"])
	if "isEducated" in attributes:
		citizen.setEducated(attributes["isEducated"])
	if "job" in attributes:
		citizen.setJob(attributes["job"])
	if "residence" in attributes:
		citizen.setResidence(attributes["residence"])
	return citizen

# Function to convert a Citizen object to a dictionary for JSON
func citizen_to_dict(citizen: Citizen) -> Dictionary:
	return {
		"name": citizen.name,
		"immunity": citizen.immunity,
		"isVaccinated": citizen.getVaccinated(),
		"isMasked": citizen.getMasked(),
		"isEducated": citizen.getEducated(),
		"job": {"x": citizen.getJob().x, "y": citizen.getJob().y},
		"residence": {"x": citizen.getResidence().x, "y": citizen.getResidence().y}
	}

# Function to write a Citizen object to a JSON file
func write_citizen_to_json_file(citizen: Citizen, file_path: String) -> void:
	var file = File.new()
	if file.open(file_path, File.WRITE) == OK:
		# Convert citizen object to a dictionary and then to JSON
		var citizen_dict = citizen_to_dict(citizen)
		var json_string = JSON.print(citizen_dict, "\t")  # Pretty-print
		file.store_string(json_string)
		file.close()
		print("Citizen written to JSON file successfully.")
	else:
		print("Failed to open file for writing: " + file_path)

# Example usage
func _ready():
	# Define attributes for a new citizen
	var citizen_attributes = {
		"name": "John Doe",
		"immunity": 0.6,
		"isVaccinated": true,
		"isMasked": false,
		"isEducated": true,
		"job": Vector2(10, 15),
		"residence": Vector2(5, 7)
	}

	# Initialize Citizen object
	var citizen = initialize_citizen(citizen_attributes)

	# File path to write the JSON
	var file_path = "res://citizen_data.json"

	# Write Citizen object to JSON file
	write_citizen_to_json_file(citizen, file_path)
