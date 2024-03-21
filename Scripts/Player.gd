extends CharacterBody2D

# follow tutorial https://www.youtube.com/watch?v=mJ1ZfGDTMCY

var WheelDistance = 70
var SteeringAngle = 25

var SteerDirection = 15

var EnginePower = 600
var Acceleration = Vector2.ZERO

var Friction = -.9
var Drag = -0.001
var Braking = -450
var MaxSpeedReverse = 250
var SlipSpeed = 400
var TractionFast = 0.1
var TractionSlow = 0.5

func _physics_process(delta):
	Acceleration = Vector2.ZERO
	GetInput()
	ApplyFriction()
	CalculateSteering(delta)
	velocity += Acceleration * delta
	move_and_slide()

func GetInput():
	var turn = 0
	if Input.is_action_pressed("steer_left"):
		turn -= 1
	if Input.is_action_pressed("steer_right"):
		turn += 1

	SteerDirection = turn * deg_to_rad(SteeringAngle)

	if Input.is_action_pressed("accelerate"):
		Acceleration = transform.x * EnginePower

	if Input.is_action_pressed("decelerate"):
		Acceleration = transform.x * Braking

func ApplyFriction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var frictionForce = velocity * Friction
	var dragForce = velocity * velocity.length() * Drag
	Acceleration += dragForce + frictionForce

func CalculateSteering(delta):
	var rearWheel = position - transform.x * (WheelDistance / 2)
	var frontWheel = position + transform.x * (WheelDistance / 2)
	rearWheel += velocity * delta
	frontWheel += velocity.rotated(SteerDirection) * delta

	var newHeading = (frontWheel - rearWheel).normalized()

	var traction = TractionSlow

	if velocity.length() > SlipSpeed:
		traction = TractionFast

	var dotProduct = newHeading.dot(velocity.normalized())
	if dotProduct > 0:
		velocity = velocity.lerp(newHeading * velocity.length(), traction)
	if dotProduct < 0:
		velocity = -newHeading * min(velocity.length(), MaxSpeedReverse)
	rotation = newHeading.angle()

