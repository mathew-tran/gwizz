extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var policeman = get_tree().get_nodes_in_group("Policeman1")
	if policeman:
		var string = "'Greg.Before you start your deliveries today. I bought some donuts for you at the donut shop!'\n"
		string += "'It's on the east side'\n"
		string += "'See you later!'\n"
		string += "'Gwizz says hi!'\n"
		string += "'BARK BARK'\n"
		string += "....\n"
		string += "You work as a delivery driver\n"
		string += "You make ends meet by doing deliveries.\n"
		string += ".. Hopefully today will not be so eventful \n"
		string += "Gwizz (your dog) often gets into trouble."


		policeman[0].OverridePoliceman(string, self)


func Execute():
	var gates = get_tree().get_nodes_in_group("TutorialGate")
	if gates:
		for gate in gates:
			gate.queue_free()
	CompleteObjective()
