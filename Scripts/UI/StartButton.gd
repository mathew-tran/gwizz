extends Button




func _on_button_up():
	disabled = true
	$AudioStreamPlayer.play()
	await $AudioStreamPlayer.finished
	get_tree().change_scene_to_packed(load("res://Scenes/Main.tscn"))

