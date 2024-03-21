extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var string = "Remember to get some donuts! Greg already paid for them for you! \n"
	string += "Find some donuts on the east side of town."

	Helper.SendDialogue(string)
	EventManager.DonutInteract.connect(OnDonutInteract)

func OnDonutInteract():
	CompleteObjective()

