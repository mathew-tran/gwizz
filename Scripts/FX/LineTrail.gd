extends Line2D

var MaxPoints = 25
@onready var curve = Curve2D.new()
@export var ParentRef : NodePath
func _ready():

	await get_tree().process_frame
	reparent(get_parent(), false)
func _process(delta):
	global_position = Vector2.ZERO
	global_rotation_degrees = 0

	var newPoint = (get_node(ParentRef).global_position)
	curve.add_point(newPoint)
	if curve.get_baked_points().size() > MaxPoints:
		curve.remove_point(0)
	points = curve.get_baked_points()

func Stop():
	set_process(false)
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 3.0)
	await tween.finished
	queue_free()
