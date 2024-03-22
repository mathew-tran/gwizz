extends Control

func _ready():
	$AnimationPlayer.play("anim")
	visible = false

func _on_timer_timeout():
	var demons = Finder.GetDemons()
	var bIsChasing = false
	if demons:
		for demon in demons:
			if demon.IsChasing():
				bIsChasing = true
				break
	if bIsChasing:
		visible = true
	else:
		visible =false
