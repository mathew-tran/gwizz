extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var string = "Remember to get some donuts! Greg already paid for them for you! \n"
	string += "Find some donuts on the east side of town."

	Helper.SendDialogue(string)
	EventManager.DonutInteract.connect(OnDonutInteract)

	var donutShop = Finder.GetInteractWithTag("DonutMission")
	if donutShop:
		Helper.SetTarget(donutShop.global_position)
		var newContent = "You eat some donuts!\n"
		newContent += "Tasty! Now on to the next in the list.."
		donutShop.Content = newContent



func OnDonutInteract():
	CompleteObjective()
	var donutShop = Finder.GetInteractWithTag("DonutMission")
	if donutShop:
		donutShop.queue_free()


