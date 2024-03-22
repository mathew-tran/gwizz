extends Area2D

@export var InteractType : Definitions.INTERACT_TYPE
@export var EventType : EventManager.INTERACT_EVENT
@export_multiline var Content
@export var GroupTag = "null"

func _ready():
	add_to_group(GroupTag)

func OnInteract():
	Helper.SendDialogue(Content)
	EventManager.BroadcastInteract(EventType)

func GetInteractType():
	return InteractType
