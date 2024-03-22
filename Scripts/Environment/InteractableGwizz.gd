extends Area2D

@export var InteractType : Definitions.INTERACT_TYPE
@export_multiline var Content
var CurrentContent

@export var AnimToPlay = "RESET"
func _ready():
	CurrentContent = Content
	Animate(AnimToPlay)


func Animate(animName):
	$Gwizz/AnimationPlayer.play(animName)

func OnInteract():
	Helper.SendDialogue(CurrentContent)


func GetInteractType():
	return InteractType
