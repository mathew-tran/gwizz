extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true

func _input(event):
	if bIsTracking:
		if event.is_action_pressed("decelerate"):
			CompleteObjective()
			bIsTracking = false

