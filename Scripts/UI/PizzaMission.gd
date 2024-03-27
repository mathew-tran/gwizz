extends MissionObjective

var bIsTracking = false

func StartTracking():
	bIsTracking = true
	var string = "You need to get some Pizza for the party.\n"
	string += "It's south of town\n"

	Helper.SendDialogue(string)
	EventManager.PizzaInteract.connect(OnPizzaInteract)
	var pizzaShop = Finder.GetInteractWithTag("PizzaMission")
	if pizzaShop:
		Helper.SetTarget(pizzaShop.global_position)
		var newContent = "You collect the pizza's!\n"
		newContent += "Ten Large Hawaiian Pizza's! Now on to the next in the list.."
		pizzaShop.Content = newContent


func OnPizzaInteract():
	CompleteObjective()
	var pizzaShop = Finder.GetInteractWithTag("PizzaMission")
	if pizzaShop:
		pizzaShop.queue_free()





