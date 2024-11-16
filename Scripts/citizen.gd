class_name Citizen

var name: String

# range = 0.0 - 1.0
# avg. = 0.3
# max_start = .7
# min_start = .05
var immunity: float
var sick_length: int

var isVaccinated: bool
var isMasked: bool
var isInfected: bool
var isEducated: bool
var isDead: bool

var job: Vector2i
var residence: Vector2i

func _init(name: String, immunity: float, sick_length: float, edu_prob: float):
	self.name = name
	self.immunity = immunity
	self.sick_length = sick_length
	self.isVaccinated = false
	self.isMasked = false
	self.isInfected = false
	self.isEducated = randf() < edu_prob
	self.isDead = false

func getName() -> String:
	return self.name

func getImmunity() -> float:
	return self.immunity
	
func getSickLength() -> int:
	return self.sick_length

func getVaccinated() -> bool:
	return self.isVaccinated
	
func setVaccinated(vaccinated: bool) -> void:
	self.isVaccinated = vaccinated
	
func getMasked() -> bool:
	return self.isMasked
	
func setMasked(masked: bool) -> void:
	self.isMasked = masked
	
func getEducated() -> bool:
	return self.isEducated

func setEducated(educated: bool) -> void:
	self.isEducated = educated
	
func getDead() -> bool:
	return self.isDead

func setDead(dead) -> void:
	self.isDead = dead
	
func getJob() -> Vector2i:
	return self.job

func setJob(job: Vector2i) -> void:
	self.job = job
	
func getResidence() -> Vector2i:
	return self.residence

func setResidence(residence: Vector2i) -> void:
	self.residence = residence
