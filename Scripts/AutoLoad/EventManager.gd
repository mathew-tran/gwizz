extends Node

enum INTERACT_EVENT {
	BASIC,
	DONUT
}

signal BasicInteract
signal DonutInteract

func BroadcastInteract(interactType):
	if interactType == INTERACT_EVENT.BASIC:
		emit_signal("BasicInteract")
	elif interactType == INTERACT_EVENT.DONUT:
		emit_signal("DonutInteract")
