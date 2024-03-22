extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var string = "Oh right! Need to get some kibble\n"
	string += "It should be close to the donut shop.\n"

	Helper.SendDialogue(string)
	EventManager.KibbleInteract.connect(OnKibbleInteract)
	var kibbleShop = Finder.GetInteractWithTag("KibbleMission")
	if kibbleShop:
		var newContent = "You collect the Kibble!\n"
		newContent += "Gwizz will sure love this!.."
		kibbleShop.Content = newContent


func OnKibbleInteract():
	CompleteObjective()
	var kibbleShop = Finder.GetInteractWithTag("KibbleMission")
	if kibbleShop:
		kibbleShop.queue_free()






