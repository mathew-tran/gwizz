extends Node


func GetDialogue():
	var result = get_tree().get_nodes_in_group("DIALOGUE")
	if result:
		return result[0]
	return null

func GetPlayer():
	var result = get_tree().get_nodes_in_group("Player")
	if result:
		return result[0]
	return null

func GetInteractWithTag(tag):
	var result = get_tree().get_nodes_in_group(tag)
	if result:
		return result[0]
	return null

func GetGwizz():
	var result = get_tree().get_nodes_in_group("Gwizz")
	if result:
		return result[0]
	return null
