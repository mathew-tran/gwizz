extends Node2D

var PlayerRef = null
var Target = Vector2.ZERO


func _ready():
	PlayerRef = Finder.GetPlayer()
	add_to_group("Target")
	$AnimationPlayer.play("animArrow")

func FollowPoint(newPoint):
	Target = newPoint

func _physics_process(delta):
	if PlayerRef:
		if visible:
			$Guide.global_position = PlayerRef.global_position - Vector2(0, 64)
func _on_timer_timeout():
	if Target != Vector2.ZERO:
		visible = true and GameTimer.bIsChasing == false
		$Guide.visible = false
		$GuideLocked.visible = false
		if PlayerRef.global_position.distance_to(Target) < 200:
			$GuideLocked.global_position = Target
			$GuideLocked.visible = true

		else:
			var dir = PlayerRef.global_position.direction_to(Target)
			$Guide.rotation =  dir.angle()
			$Guide.visible = true

			print($Guide.rotation_degrees)
	else:
		visible = false
