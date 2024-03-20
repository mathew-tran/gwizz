extends Sprite2D

var TalkCursor = preload("res://Art/TalkCursor.png")
var NormalCursor = preload("res://Art/Cursor.png")
var MagnifyingCursor = preload("res://Art/MagnifyingCursor.png")

var InteractObject = null
func _ready():
	Input.set_custom_mouse_cursor(NormalCursor)

func _physics_process(delta):
	global_position = get_global_mouse_position()
func UpdateCursor(interactType):
	if interactType == Definitions.INTERACT_TYPE.NORMAL:
		Input.set_custom_mouse_cursor(NormalCursor)
	elif interactType == Definitions.INTERACT_TYPE.INVESTIGATE:
		Input.set_custom_mouse_cursor(MagnifyingCursor)
	elif interactType == Definitions.INTERACT_TYPE.TALK:
		Input.set_custom_mouse_cursor(TalkCursor)

func _input(event):
	if InteractObject:
		if event.is_action_released("click"):
			InteractObject.OnInteract()
			Input.set_custom_mouse_cursor(NormalCursor)

func _on_area_2d_area_entered(area):
	print(area.name + " entered")
	UpdateCursor(area.GetInteractType())
	InteractObject = area


func _on_area_2d_area_exited(area):
	UpdateCursor(Definitions.INTERACT_TYPE.NORMAL)
	InteractObject = null

