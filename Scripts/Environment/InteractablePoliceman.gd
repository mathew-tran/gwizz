extends Area2D

@export var InteractType : Definitions.INTERACT_TYPE
@export_multiline var Content
var CurrentContent

var bIsHooked = false
var MissionRef

func _ready():
	CurrentContent = Content

func OverridePoliceman(overrideContent, missionRef):
	bIsHooked = true
	MissionRef = missionRef
	CurrentContent = overrideContent


func OnInteract():
	Helper.SendDialogue(CurrentContent)
	if bIsHooked:
		HookPoliceManToBlocks()
		bIsHooked = false

func HookPoliceManToBlocks():
	Finder.GetDialogue().DialogueComplete.connect(OnFinishedTalking)

func OnFinishedTalking():
	Finder.GetDialogue().DialogueComplete.disconnect(OnFinishedTalking)
	MissionRef.Execute()
	MissionRef = null
	CurrentContent = "Move along"


func GetInteractType():
	return InteractType
