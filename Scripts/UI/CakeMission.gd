extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var string = "You need to get some Cake for the party.\n"
	string += "It should be a bit east of here.\n"

	Helper.SendDialogue(string)
	EventManager.CakeInteract.connect(OnCakeInteract)
	var cakeShop = Finder.GetInteractWithTag("CakeMission")
	if cakeShop:
		Helper.SetTarget(cakeShop.global_position)
		var newContent = "You collect the Cake!\n"
		newContent += "A large chocolate ice cream cake with fudge!.."
		cakeShop.Content = newContent


func OnCakeInteract():
	CompleteObjective()
	var cakeShop = Finder.GetInteractWithTag("CakeMission")
	if cakeShop:
		cakeShop.queue_free()
