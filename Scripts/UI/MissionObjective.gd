extends HBoxContainer
class_name MissionObjective

signal CompletedObjective

func _ready():
	$AnimationPlayer.play("animIn")

func StartTracking():
	pass

func CompleteObjective():
	$AudioStreamPlayer.play()
	$AnimationPlayer.play("animate")
	await $AnimationPlayer.animation_finished
	await get_tree().create_timer(2).timeout
	visible = false
	emit_signal("CompletedObjective")
	queue_free()
