extends TileMap

signal finished_render
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
					print(Vector2i(y,x))
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
				"W":
					set_cell(0, Vector2i(y,x), 0, Vector2i(0, 4))
					Controller.places[Vector2i(y,x)] = [id, 3]
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
