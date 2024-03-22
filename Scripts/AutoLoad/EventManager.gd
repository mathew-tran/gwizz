extends Node

enum INTERACT_EVENT {
	BASIC,
	DONUT,
	PIZZA,
	CAKE,
	KIBBLE,
	PARTY,
	ALCOHOL,
	HOME
}

signal BasicInteract
signal DonutInteract
signal PizzaInteract
signal CakeInteract
signal KibbleInteract
signal PartyHatInteract
signal AlcoholInteract
signal HomeInteract

signal PlayerStopped
signal PlayerMoving

func BroadcastInteract(interactType):
	if interactType == INTERACT_EVENT.BASIC:
		emit_signal("BasicInteract")
	elif interactType == INTERACT_EVENT.DONUT:
		emit_signal("DonutInteract")
	elif interactType == INTERACT_EVENT.PIZZA:
		emit_signal("PizzaInteract")
	elif interactType == INTERACT_EVENT.CAKE:
		emit_signal("CakeInteract")
	elif interactType == INTERACT_EVENT.KIBBLE:
		emit_signal("KibbleInteract")
	elif interactType == INTERACT_EVENT.PARTY:
		emit_signal("PartyHatInteract")
	elif interactType == INTERACT_EVENT.ALCOHOL:
		emit_signal("AlcoholInteract")
	elif interactType == INTERACT_EVENT.HOME:
		emit_signal("HomeInteract")

func BroadcastPlayerStopped():
	emit_signal("PlayerStopped")

func BroadcastPlayerMoving():
	emit_signal("PlayerMoving")
