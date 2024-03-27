extends MissionObjective

var bIsTracking = false

func StartTracking():

	bIsTracking = true
	var policeman = get_tree().get_nodes_in_group("Policeman1")
	if policeman:
		Helper.SetTarget(policeman[0].get_global_position())
		var string = "'Greg.Before you start for Gwizz's big today. I bought some donuts for you at the donut shop!'\n"
		string += "'It's on the east side'\n"
		string += "'See you later!'\n"
		string += "'Gwizz says hi!'\n"
		string += "'BARK BARK'\n"
		string += "....\n"
		string += "Today is your dogs birthday\n"
		string += "You need to go out and get supplies so the birthday can happen\n"
		string += "Don't be late!"
		policeman[0].OverridePoliceman(string, self)


func Execute():
	var gates = get_tree().get_nodes_in_group("TutorialGate")
	if gates:
		for gate in gates:
			gate.queue_free()
	CompleteObjective()
