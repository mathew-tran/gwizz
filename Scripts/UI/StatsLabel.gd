extends Label


# Called when the node enters the scene tree for the first time.
func _ready():

	var newText =  "STATS\n"
	newText += GameTimer.GetFrogsKilled() + "\n"
	newText += GameTimer.GetDistanceTravelled()
	text = newText
