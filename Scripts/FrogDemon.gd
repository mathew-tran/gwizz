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


func StartChasing():
	if bCanStartChasing ==false or bIsDead:
		return
	Helper.SendDialogue("A frog demon has taken notice of Gwizz!\n Run the demon over to protect him from Gwizz!")
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
		bStartChasingAfterDog = false

		if bCanStartChasing:
			Hits -= 2
		Hits -= 1

		if Hits <= 0:
			print("dead")
			$Sprite.texture = DeadSprite
			$HitTimer.stop()
			bIsDead = true
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
