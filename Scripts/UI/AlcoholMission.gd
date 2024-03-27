extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var string = "You need to get some drinks for the party!\n"
	string += "It's north of the house if I can recall..\n"

	Helper.SendDialogue(string)
	EventManager.AlcoholInteract.connect(OnAlcoholInteract)
	var shop = Finder.GetInteractWithTag("AlcoholMission")
	if shop:
		Helper.SetTarget(shop.global_position)
		var newContent = "You collect the drinks!\n"
		newContent += "This party will be a fun one!"
		shop.Content = newContent


func OnAlcoholInteract():
	CompleteObjective()
	var shop = Finder.GetInteractWithTag("AlcoholMission")
	if shop:
		shop.queue_free()
