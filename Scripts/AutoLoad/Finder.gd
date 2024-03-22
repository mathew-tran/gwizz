extends Node


func GetDialogue():
	var result = get_tree().get_nodes_in_group("DIALOGUE")
	if result:
		return result[0]
	return null

func GetInteractWithTag(tag):
	var result = get_tree().get_nodes_in_group(tag)
	if result:
		return result[0]
	return null
