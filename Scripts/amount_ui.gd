extends RichTextLabel

func _input(event):
	self.text = "AVAILABLE BEDS: "+str(Controller.bed_available)+"\n\nAVAILABLE POSTERS:"+str(Controller.post_available)+"\n\nAVAILABLE MASKS: "+str(Controller.mask_available)+"\n\nAVAILABLE VAXXES: "+str(Controller.vax_available)+"\n\nTOTAL BEDS: "+str(Controller.beds_total + Controller.beds_bought)+"\n\nTOTAL POSTERS: "+str(Controller.posters_total + Controller.posters_bought)+"\n\nTOTAL MASKS: "+str(Controller.masks_total + Controller.masks_bought)+"\n\nTOTAL VAXXES: "+str(Controller.vaccines_total + Controller.vaccines_bought)
