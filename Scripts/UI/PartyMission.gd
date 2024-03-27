extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var string = "Let's get some balloons and party hats\n"
	string += "The place to get it should be close to home!\n"

	Helper.SendDialogue(string)
	EventManager.PartyHatInteract.connect(OnPartyConnect)
	var shop = Finder.GetInteractWithTag("PartyMission")
	if shop:
		Helper.SetTarget(shop.global_position)
		var newContent = "You collect the hats and baloons!\n"
		newContent += "Gwizz will look amazing in his party hat!"
		shop.Content = newContent


func OnPartyConnect():
	CompleteObjective()
	var shop = Finder.GetInteractWithTag("PartyMission")
	if shop:
		shop.queue_free()






