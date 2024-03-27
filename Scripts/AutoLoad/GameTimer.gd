extends Node

var bCanRecord = false

var Value = 0

var OldRecord = 999999

var DistanceTravelled = 0.0
var FrogsKilled = 0
var Dings = 0

var LastPlayerPosition = Vector2.ZERO

var PollTimer = null

var PlayerRef = null

var bFirstTimeChase = false
var bFirstTimePlay = true

var bIsChasing = false

func _ready():
	bCanRecord = false
	PollTimer = Timer.new()
	PollTimer.autostart = false
	PollTimer.one_shot = false
	PollTimer.wait_time = .5
	add_child(PollTimer)
	PollTimer.timeout.connect(OnPollTimeout)

func OnPollTimeout():
	if is_instance_valid(PlayerRef) == false:
		return
	var currentPosition = PlayerRef.global_position
	DistanceTravelled += currentPosition.distance_to(LastPlayerPosition)
	LastPlayerPosition = currentPosition

func _process(delta):
	Value += delta

func Start():
	bFirstTimeChase = false
	Value = 0.0
	DistanceTravelled = 0.0
	FrogsKilled = 0
	Dings = 0
	bCanRecord = true
	PlayerRef = Finder.GetPlayer()
	LastPlayerPosition = PlayerRef.global_position
	PollTimer.start()


func Stop():
	bCanRecord = false
	PollTimer.stop()

func EstablishRecord():
	if Value < OldRecord:
		OldRecord = Value

func IsNewRecord():
	return Value < OldRecord

func GetTime():
	var minutes = 0
	var timeAmount = Value
	while timeAmount >= 60:
		minutes += 1
		timeAmount -= 60
	timeAmount = snapped(timeAmount, .01)
	return str(minutes) + " minutes, " + str(timeAmount) + " seconds"

func GetFrogsKilled():
	return str(FrogsKilled) + " frogs killed"

func GetDistanceTravelled():
	var amount = DistanceTravelled/10000

	return str(snapped(amount, .01)) + "km travelled"

func GetDings():
	return str(Dings) + " dings"
