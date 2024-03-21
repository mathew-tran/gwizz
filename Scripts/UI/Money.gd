extends Control

var bStoppedFirst = false
var bStoppedAgain = true
func _ready():
	EventManager.PlayerMoving.connect(OnPlayerMoving)
	EventManager.PlayerStopped.connect(OnPlayerStopped)

func OnPlayerMoving():
	bStoppedFirst = false

	if bStoppedAgain:
		$AnimationPlayer.play_backwards("animIn")
	bStoppedAgain = false

func OnPlayerStopped():
	if bStoppedFirst == false:
		bStoppedFirst = true
		return
	if bStoppedFirst and bStoppedAgain == false:
		bStoppedAgain = true
		$AnimationPlayer.play("animIn")
