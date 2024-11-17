extends RichTextLabel

func _input(event) -> void:
	self.text = "AVAILABLE BEDS: "+str(Controller.available_bed)+"\n\nAVAILABLE POSTERS: "+str(Controller.available_post)+"\n\nAVAILABLE MASKS: "+str(Controller.available_mask)+"\n\nAVAILABLE VAXXES: "+str(Controller.available_vax)+"\n\nTOTAL BEDS: "+str(Controller.beds_total+Controller.beds_bought)+"\n\nTOTAL POSTERS: "+str(Controller.posters_total+Controller.posters_bought)+"\n\nTOTAL MASKS: "+str(Controller.masks_total+Controller.masks_bought)+"\n\nTOTAL VAXXES: "+str(Controller.vaccines_total+Controller.vaccines_bought)
