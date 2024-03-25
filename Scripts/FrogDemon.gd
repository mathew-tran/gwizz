extends Node2D

var GwizzRef = null
var PlayerRef = null

var EndPosition = Vector2.ZERO
var Speed = 50
var bStartChasingAfterDog = false
var bIsDead = false
var bCanStartChasing = true
var Hits = 3

var HitSprite = preload("res://Art/frogdemonhit.png")
var DeadSprite = preload("res://Art/frogdemondead.png")
var ChaseSprite = preload("res://Art/frogdemon.png")

func _ready():
	PlayerRef = Finder.GetPlayer()
	$StartTimer.wait_time = randf_range(0, 5)
	$StartTimer.start()


func StartChasing():
	if bCanStartChasing ==false or bIsDead:
		return
	$AudioStreamPlayer2D.pitch_scale = randf_range(.7, 1.4)
	$AudioStreamPlayer2D.play()
	if GameTimer.bFirstTimeChase == false:
		Helper.SendDialogue("A frog demon has taken notice of Gwizz!\n Run the demon over to protect him from Gwizz!")
		GameTimer.bFirstTimeChase = true
	$FrogTarget/AnimationPlayer.play("startChasingTarget")
	bStartChasingAfterDog = true
	GwizzRef = Finder.GetGwizz()
	EndPosition = GwizzRef.global_position
	if EndPosition.x < global_position.x:
		$Sprite.scale.x = -1
	bCanStartChasing = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if bIsDead:
		return
	if bStartChasingAfterDog:
		global_position = global_position.move_toward(EndPosition, delta * Speed)

func IsChasing():
	if bIsDead:
		return false
	return bCanStartChasing == false

func _on_area_2d_body_entered(body):
	if bIsDead:
		return

	if body.name == "Player":
		if body.IsMovingQuick() == false:
			return
		bStartChasingAfterDog = false

		$HitParticle.emitting = true
		body.Bump(global_position)
		var instance = load("res://Prefabs/Environment/Bloodstain.tscn").instantiate()
		instance.global_position= global_position + Vector2(randf_range(-16,16), randf_range(-16,16))
		Finder.GetBloodStains().add_child(instance)
		if bCanStartChasing:
			Hits -= 3
		else:
			Hits -= 1


		if Hits <= 0:
			print("dead")
			$Sprite.texture = DeadSprite
			$HitTimer.stop()
			bIsDead = true
			GameTimer.FrogsKilled += 1
		else:
			$HitTimer.start()
			$Sprite.texture = HitSprite
	pass # Replace with function body.


func _on_hit_timer_timeout():
	bStartChasingAfterDog = true
	$Sprite.texture = ChaseSprite
	pass # Replace with function body.


func _on_dist_check_timer_timeout():
	if PlayerRef.global_position.distance_to(global_position) < 400:
		StartChasing()
		$DistCheckTimer.stop()
	else:
		$Sprite.scale.x = -$Sprite.scale.x


func _on_start_timer_timeout():
	$DistCheckTimer.start()
