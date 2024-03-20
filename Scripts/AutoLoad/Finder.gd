extends Node


func GetDialogue():
	var result = get_tree().get_nodes_in_group("DIALOGUE")
	if result:
		return result[0]
	return null
