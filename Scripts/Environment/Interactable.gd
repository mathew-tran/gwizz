extends Area2D

@export var InteractType : Definitions.INTERACT_TYPE
@export_multiline var Content

func OnInteract():
	Helper.SendDialogue(Content)

func GetInteractType():
	return InteractType
