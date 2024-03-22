extends Area2D

@export var InteractType : Definitions.INTERACT_TYPE
@export_multiline var Content
var CurrentContent
var GwizzDeadSprite = preload("res://Art/GwizzDead.png")
var bIsDead = false

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


func _on_area_entered(area):
	if bIsDead:
		return
	var obj = area.get_parent().get_parent()
	print(area.get_parent().get_parent().name)
	if obj.is_in_group("Demon"):
		print("die")
		$Gwizz.texture = GwizzDeadSprite
		bIsDead = true
		$DeadTimer.start()



func _on_timer_timeout():
	Finder.GetDialogue().DialogueComplete.connect(OnDialogueComplete)
	Helper.SendDialogue("Gwizz has died by a frog demon!\nTake better care of him..")

func OnDialogueComplete():
	get_tree().change_scene_to_packed(load("res://Scenes/Start.tscn"))
