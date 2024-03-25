extends Area2D


func _on_music_finished():
	$Timer.start()


func _on_timer_timeout():
	$Music.play()


func _on_body_entered(body):
	$Music.play()
	$CollisionShape2D.set_deferred("disabled", true)
