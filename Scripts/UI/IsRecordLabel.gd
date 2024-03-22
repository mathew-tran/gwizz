extends Label


func _ready():
	if GameTimer.IsNewRecord():
		text = "NEW RECORD"
		GameTimer.EstablishRecord()
	else:
		text = ""
