extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var string = "Your stomach begins to grumble. You crave .. \n"
	string += "Donuts!"
	string += "Find some donuts on the west side of town."

	Helper.SendDialogue(string)

func _input(event):
	if bIsTracking:
		if event.is_action("decelerate"):
			CompleteObjective()
			bIsTracking = false
