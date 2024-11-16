class_name Citizen

var name: String

# range = 0.0 - 1.0
# avg. = 0.3
# max_start = .7
# min_start = .05
var immunity: float

var isVaccinated: bool
var isMasked: bool

# default = 0.5
var isEducated: bool

var job: Vector2i
var residence: Vector2i

func _init(name: String, immunity: float, edu_prob: float):
	self.name = name
	self.immunity = immunity
	self.isEducated = randf() < edu_prob

func getVaccinated():
	return self.isVaccinated
	
func setVaccinated(vaccinated: bool):
	self.isVaccinated = vaccinated
	
func getMasked():
	return self.isMasked
	
func setMasked(masked: bool):
	self.isMasked = masked
	
func getEducated():
	return self.isEducated

func setEducated(educated: bool):
	self.isEducated = educated
	
func getJob():
	return self.job

func setJob(job: Vector2i):
	self.job = job
	
func getResidence():
	return self.residence

func setResidence(residence: Vector2i):
	self.residence = residence
