extends Control

var Index = 0
var LastIndex = 0

var Data = []

signal DialogueComplete

var bCanSkip = true

func _ready():
	add_to_group("DIALOGUE")

func SplitString(s: String):
	var result = []
	s = s.strip_edges()
	var splitString = s.split("\n")
	for split in splitString:
		if len(split) >= 100:
			var words = split.split(" ")
			var sentence = ""
			for word in words:
				if len(sentence) + len(word) < 100:
					sentence += word + " "
				else:
					result.append(sentence)
					sentence = word + " "
			if sentence != "":
				result.append(sentence)
		else:
			result.append(split)
	return result

func ShowText(data):
	$AudioStreamPlayer.play()
	$Panel/Label.text =""
	$Panel/Label.visible_ratio= 0
	$AnimationPlayer.play("animIn")
	bCanSkip = false
	await $AnimationPlayer.animation_finished
	bCanSkip = true
	get_tree().paused = true
	Index = 0
	Data = SplitString(data["content"])

	LastIndex = len(Data)
	$AnimationPlayer.play("animText")
	$Panel/Label.text = Data[Index]
	UpdatePromptText()

func UpdatePromptText():
	if Index < LastIndex - 1:
		$"Panel/Prompt Text".text = "(Left Click / Space to continue)"
	else:
		$"Panel/Prompt Text".text = "(Left Click  / Space to end)"

func Close():
	$AnimationPlayer.play_backwards("animIn")
	await $AnimationPlayer.animation_finished
	get_tree().paused = false
	$Panel/Label.text =""
	$Panel/Label.visible_ratio = 0
	emit_signal("DialogueComplete")

func PaginateForward():
	if bCanSkip == false:
		return
	Index += 1
	if Index >= LastIndex:
		Close()
		Data = null
	else:
		bCanSkip = false
		$AnimationPlayer.play("animText")
		$AudioStreamPlayer.play()
		bCanSkip = true
		$Panel/Label.text = Data[Index]
		UpdatePromptText()

func _input(event):
	if Data:
		if event.is_action_pressed("click") or event.is_action_pressed("space"):
			PaginateForward()
