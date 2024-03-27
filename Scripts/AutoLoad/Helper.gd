extends Node

func SendDialogue(content):
	var dialogue = Finder.GetDialogue()
	if dialogue:
		dialogue.ShowText({"content" : content})

func SetTarget(newTargetPosition):
		Finder.GetGuide().FollowPoint(newTargetPosition)
