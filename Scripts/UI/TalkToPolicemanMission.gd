extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var policeman = get_tree().get_nodes_in_group("Policeman1")
	if policeman:
		var string = "Mister Gwizz. You got bailed out..\n"
		string += "Make sure I don't catch you eating people again.\n"
		string += "I'll open the gates.. now\n"

		policeman[0].OverridePoliceman(string, self)


func Execute():
	var gates = get_tree().get_nodes_in_group("TutorialGate")
	if gates:
		for gate in gates:
			gate.queue_free()
	CompleteObjective()
