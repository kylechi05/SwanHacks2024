extends TileMap

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var temp_file = FileAccess.open("res://GameData/map.txt", FileAccess.READ)
	var temp_string = temp_file.get_as_text().replace('\n', '')
	 	
	var i = 0
	var map_width = Controller.MAP_SIZE.x
	while i * map_width < temp_string.length():
		Controller.collision_data.append(temp_string.substr(i*map_width, map_width) )
		i += 1
	#Controller.collision_data.reverse()
	print(Controller.collision_data)
	read_map()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func read_map():
	for x in range(len(Controller.collision_data)):
		for y in range(len(Controller.collision_data[x])):
			match Controller.collision_data[x][y]:
				"0":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 0))
				"r":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 1))
				"H":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 2))
				"W":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 3))
	print("map created")
