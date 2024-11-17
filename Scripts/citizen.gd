extends Sprite2D

class_name Citizen

var citizen_name: String
var location: Vector2i

# range = 0.0 - 1.0
# avg. = 0.3
# max_start = .7
# min_start = .05
var immunity: float
var total_sick_length: float
var current_sick_length: float

var isVaccinated: bool
var isMasked: bool
var isInfected: bool
var isHospitalized: bool
var isEducated: bool
var isDead: bool

var work: Vector2i
var home: Vector2i

func _init(name: String, immunity: float, total_sick_length: float, edu_prob: float, home: Vector2i, work: Vector2i):
	self.citizen_name = name
	self.immunity = immunity
	self.total_sick_length = total_sick_length
	self.isVaccinated = false
	self.isMasked = false
	self.isInfected = false
	self.isEducated = randf() < edu_prob
	self.isHospitalized = false
	self.isDead = false
	self.home = home
	self.work = work
	self.location = home

func getName() -> String:
	return self.citizen_name

func getLocation() -> Vector2i:
	return self.location

func setLocation(location: Vector2i) -> void:
	self.location = location

func getImmunity() -> float:
	return self.immunity
	
func getTotalSickLength() -> float:
	return self.total_sick_length
	
func getCurrentSickLength() -> float:
	return self.current_sick_length

func setCurrentSickLength(length: float) -> void:
	self.current_sick_length = length

func getVaccinated() -> bool:
	return self.isVaccinated
	
func setVaccinated(vaccinated: bool) -> void:
	self.isVaccinated = vaccinated
	self.immunity = 0.85
	
func getMasked() -> bool:
	return self.isMasked
	
func setMasked(masked: bool) -> void:
	self.isMasked = masked
	if masked:
		self.immunity += 0.10
	else:
		self.immunity -= 0.10
	
func getEducated() -> bool:
	return self.isEducated

func setEducated(educated: bool) -> void:
	self.isEducated = educated
	
func getInfected() -> bool:
	return self.isInfected
	
func setInfected(infected: bool) -> void:
	self.isInfected = infected

func getHospitalized() -> bool:
	return self.isHospitalized

func setHospitalized(hospitalized) -> void:
	self.isHospitalized = hospitalized
	
func getDead() -> bool:
	return self.isDead

func setDead(dead) -> void:
	self.isDead = dead
	
func getWork() -> Vector2i:
	return self.work

func setWork(work: Vector2i) -> void:
	self.work = work
	
func getHome() -> Vector2i:
	return self.home

func setHome(home: Vector2i) -> void:
	self.home = home
