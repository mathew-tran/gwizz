extends Node

func SendDialogue(content):
	var dialogue = Finder.GetDialogue()
	if dialogue:
		dialogue.ShowText({"content" : content})
