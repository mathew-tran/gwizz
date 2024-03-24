extends CharacterBody2D

# follow tutorial https://www.youtube.com/watch?v=mJ1ZfGDTMCY

var WheelDistance = 70
var SteeringAngle = 25

var SteerDirection = 15

var EnginePower = 800
var Acceleration = Vector2.ZERO

var Friction = -.9
var Drag = -0.001
var Braking = -450
var HardBrake = -600
var MaxSpeedReverse = 250
var SlipSpeed = 400
var TractionFast = 0.1
var TractionSlow = 0.5
var TractionBreak = 0.6

var BuildUpPower = 0
var MaxBuildUpPower = 100

var bIsBraking = false
var bStop = false

func _ready():
	$TailLights.visible = false
func _process(delta):
	if velocity != Vector2.ZERO:
		var coll = get_last_slide_collision()
		if coll:
			$CollideParticle.global_position =coll.get_position()
			$CollideParticle.emitting = true

func IsMovingQuick():
	return velocity.length() > 10

func Bump(pos):
	velocity *= .5
	$CollideParticle.global_position = pos
	$CollideParticle.emitting = true
	$AnimationPlayer.play("screen_shake")

func _physics_process(delta):
	Acceleration = Vector2.ZERO
	GetInput(delta)
	ApplyFriction()
	CalculateSteering(delta)

	if bStop:
		return

	velocity += Acceleration * delta
	move_and_slide()

func EmitSmokeTrail():
	$GPUParticles2D.emitting = true
	$GPUParticles2D2.emitting = true

func EmitWheelieTrail(amount):
	if $WheelieParticle.emitting == true:
		return
	$WheelieParticle.scale_amount_max = amount
	$WheelieParticle2.scale_amount_max = amount
	$WheelieParticle.emitting = true
	$WheelieParticle2.emitting = true

func GetInput(delta):
	var turn = 0
	if Input.is_action_pressed("steer_left"):
		turn -= 1
	if Input.is_action_pressed("steer_right"):
		turn += 1

	SteerDirection = turn * deg_to_rad(SteeringAngle)

	var bIsAccelerating = false

	if Input.is_action_pressed("accelerate"):
		Acceleration = transform.x * EnginePower
		$TailLights.visible = false
		EmitSmokeTrail()
		bIsAccelerating = true
	if Input.is_action_pressed("decelerate"):
		Acceleration = transform.x * Braking
		$TailLights.visible = true

	if Input.is_action_pressed("brake"):
		Acceleration = transform.x * HardBrake
		bIsBraking = true
		$TailLights.visible = true
	else:
		bIsBraking = false

	if Acceleration == Vector2.ZERO:
		$TailLights.visible = false

	if bIsBraking and bIsAccelerating:

		BuildUpPower += delta * 50
		if BuildUpPower >= MaxBuildUpPower:
			BuildUpPower = MaxBuildUpPower

		var weight = BuildUpPower / MaxBuildUpPower
		var newScale = lerpf(.1, 1.2, weight)
		EmitWheelieTrail(newScale)
		rotation_degrees += delta * turn * 120
	elif bIsAccelerating and BuildUpPower > 0:
		Acceleration *= BuildUpPower
		BuildUpPower = 0
	else:
		BuildUpPower = 0


func ApplyFriction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO

	var frictionForce = velocity * Friction
	var dragForce = velocity * velocity.length() * Drag
	Acceleration += dragForce + frictionForce

func GetNewHeading(delta):
	var rearWheel = position - transform.x * (WheelDistance / 2)
	var frontWheel = position + transform.x * (WheelDistance / 2)
	rearWheel += velocity * delta
	frontWheel += velocity.rotated(SteerDirection) * delta

	var newHeading = (frontWheel - rearWheel).normalized()
	return newHeading

func CalculateSteering(delta):
	var newHeading = GetNewHeading(delta)

	var traction = TractionSlow

	if velocity.length() > SlipSpeed:
		traction = TractionFast

	if bIsBraking:
		traction = TractionBreak

	bStop = false
	var dotProduct = newHeading.dot(velocity.normalized())
	if dotProduct > 0:
		velocity = velocity.lerp(newHeading * velocity.length(), traction)
	if dotProduct < 0:
		velocity = -newHeading * min(velocity.length(), MaxSpeedReverse)
	if bIsBraking:
		if dotProduct <= 0:
			if velocity.length() >= 0:
				bStop = true
				velocity = Vector2.ZERO
				move_and_slide()

	rotation = newHeading.angle()



func _on_move_check_timer_timeout():
	if velocity == Vector2.ZERO:
		EventManager.BroadcastPlayerStopped()
	else:
		EventManager.BroadcastPlayerMoving()

