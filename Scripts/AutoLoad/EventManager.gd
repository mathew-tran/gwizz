extends Node

enum INTERACT {
	BASIC,
	DONUT
}

signal BasicInteract
signal DonutInteract

func BroadcastInteract(interactType):
	if interactType == INTERACT.BASIC:
		emit_signal("BasicInteract")
	elif interactType == INTERACT.DONUT:
		emit_signal("DonutInteract")
