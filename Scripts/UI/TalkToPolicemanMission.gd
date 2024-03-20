extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var policeman = get_tree().get_nodes_in_group("Policeman1")
	if policeman:
		var string = "Hey Mister Gwizz. Due to your poor behaviour as of late...\n You must do some community service.\n"
		string += "Be ready for some messages from me\n"
		string += "I'll open the gates.. now\n"

		policeman[0].OverridePoliceman(string, self)

func _input(event):
	if bIsTracking:
		if event.is_action("decelerate"):
			CompleteObjective()
			bIsTracking = false

func Execute():
	var gates = get_tree().get_nodes_in_group("TutorialGate")
	if gates:
		for gate in gates:
			gate.queue_free()
	CompleteObjective()
