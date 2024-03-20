extends HBoxContainer
class_name MissionObjective

signal CompletedObjective


func StartTracking():
	pass

func CompleteObjective():
	$AnimationPlayer.play("animate")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(2).timeout
	visible = false
	emit_signal("CompletedObjective")
	queue_free()
