extends Area2D

@export_multiline var Content

@export var bOneTime = false
func _on_body_entered(body):
	Helper.SendDialogue(Content)
	if bOneTime:
		queue_free()

