extends Node

var SecondTimer = null

var Value = 0

var OldRecord = 999999
func _ready():
	SecondTimer = Timer.new()
	add_child(SecondTimer)
	SecondTimer.wait_time = .01
	SecondTimer.one_shot = false
	SecondTimer.timeout.connect(OnTimerTimeout)

func OnTimerTimeout():
	Value += SecondTimer.wait_time

func Start():
	Value = 0.0
	SecondTimer.start()


func Stop():
	SecondTimer.stop()

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
