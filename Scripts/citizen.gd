class_name Citizen

var name: String
var gender: String
var immunity: float
var isVaccinated: bool
var isMasked: bool
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
	
func getJub():
	return job

func setJob(loc: Vector2):
	job = loc
	
func getResidence():
	return residence

func setResidence(res: Vector2):
	residence = res
