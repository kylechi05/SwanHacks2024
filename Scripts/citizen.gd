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

var job: Vector2
var residence: Vector2

func _init():
	pass

func getVaccinated():
	return isVaccinated
	
func setVaccinated(vacc: bool):
	isVaccinated = vacc
	
func getMasked():
	return isMasked
	
func setMasked(mask: bool):
	isMasked = mask
	
func getEducated():
	return isEducated

func setEducated(edu: bool):
	isEducated = edu
	
func getJob():
	return job

func setJob(loc: Vector2):
	job = loc
	
func getResidence():
	return residence

func setResidence(res: Vector2):
	residence = res
