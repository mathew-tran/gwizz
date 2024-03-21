extends Area2D

@export var InteractType : Definitions.INTERACT_TYPE
@export var EventType : EventManager.INTERACT_EVENT
@export_multiline var Content

func OnInteract():
	Helper.SendDialogue(Content)
	EventManager.BroadcastInteract(EventType)

func GetInteractType():
	return InteractType
