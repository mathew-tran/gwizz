extends Node

enum INTERACT_EVENT {
	BASIC,
	DONUT
}

signal BasicInteract
signal DonutInteract
signal PlayerStopped
signal PlayerMoving

func BroadcastInteract(interactType):
	if interactType == INTERACT_EVENT.BASIC:
		emit_signal("BasicInteract")
	elif interactType == INTERACT_EVENT.DONUT:
		emit_signal("DonutInteract")

func BroadcastPlayerStopped():
	emit_signal("PlayerStopped")

func BroadcastPlayerMoving():
	emit_signal("PlayerMoving")
