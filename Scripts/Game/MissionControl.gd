extends Control

@onready var Missions = $Missions

@onready var MissionPrefab = preload("res://Prefabs/UI/MissionObjective.tscn")

var MissionList = [
	#"res://Prefabs/UI/Missions/HomeMission.tscn",
	"res://Prefabs/UI/Missions/Control1Mission.tscn",
	"res://Prefabs/UI/Missions/TalkToPolicemanMission.tscn",
	"res://Prefabs/UI/Missions/DonutMission.tscn",
	"res://Prefabs/UI/Missions/PartyMission.tscn",
	"res://Prefabs/UI/Missions/AlcoholMission.tscn",
	"res://Prefabs/UI/Missions/KibbleMission.tscn",
	"res://Prefabs/UI/Missions/PizzaMission.tscn",
	"res://Prefabs/UI/Missions/CakeMission.tscn",
	"res://Prefabs/UI/Missions/HomeMission.tscn",
	]

var MissionIndex = 0

func _ready():
	StartGame()

func StartGame():
	await get_tree().process_frame

	if GameTimer.bFirstTimePlay:
		var controlString = "You seem new here. Here are the basic controls!\n"
		controlString += "W - Accelerate\n"
		controlString += "A / D - Turn \n"
		controlString += "S - Reverse \n"
		controlString += "SPACE / SHIFT - Brake\n"
		Helper.SendDialogue(controlString)
		await Finder.GetDialogue().DialogueComplete
		GameTimer.bFirstTimePlay = false
	for mission in Missions.get_children():
		mission.queue_free()
	StartMission()
	GameTimer.Start()

func StartMission():
	if MissionIndex < len(MissionList):
		var instance = load(MissionList[MissionIndex]).instantiate()
		Missions.add_child(instance)
		instance.CompletedObjective.connect(OnMissionComplete.bind())
		instance.StartTracking()
		MissionIndex += 1

func OnMissionComplete():
	print("mission completed!")
	StartMission()


func _on_timer_timeout():
	pass # Replace with function body.
