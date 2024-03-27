extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var string = "Looks like you got everything!\n"
	string += "Get home soon. So you can have a good birthday for your dog\n"

	Helper.SendDialogue(string)
	EventManager.HomeInteract.connect(OnHomeInteract)
	var shop = Finder.GetInteractWithTag("HomeMission")
	if shop:
		Helper.SetTarget(shop.global_position)
		var newContent = "Time to prepare for the party!"
		shop.Content = newContent

	var policeman = Finder.GetInteractWithTag("Policeman1")
	if policeman:
		var content = "Looks like you got the stuff!\n"
		content += "Let's setup and have a good party!\n"
		policeman.CurrentContent = content



func OnHomeInteract():
	CompleteObjective()
	var shop = Finder.GetInteractWithTag("HomeMission")
	if shop:
		shop.queue_free()
	Finder.GetDialogue().DialogueComplete.connect(OnDialogueComplete)


func OnDialogueComplete():
	GameTimer.Stop()
	get_tree().change_scene_to_packed(load("res://Scenes/end.tscn"))






