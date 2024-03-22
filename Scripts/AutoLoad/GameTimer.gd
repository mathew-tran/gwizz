extends Node

var bCanRecord = false

var Value = 0

var OldRecord = 999999
func _ready():
	bCanRecord = false

func _process(delta):
	Value += delta

func Start():
	Value = 0.0
	bCanRecord = true


func Stop():
	bCanRecord = false

func EstablishRecord():
	if Value < OldRecord:
		OldRecord = Value

func IsNewRecord():
	return Value < OldRecord

func GetTime():
	var minutes = 0
	var timeAmount = Value
	while timeAmount > 60:
		minutes += 1
		timeAmount -= 60
	timeAmount = snapped(timeAmount, .01)
	return str(minutes) + " minutes, " + str(timeAmount) + " seconds"
