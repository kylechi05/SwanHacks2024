extends Node

var num_people = 40
var edu_prob = 0.3
var imm_prob_window = {"min": 0.05, "max": 0.70}
var MAP_SIZE = Vector2(44,30)

var places = {}
var tile_array_0 = []
var collision_data = []
var citizen_astar = AStar2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
