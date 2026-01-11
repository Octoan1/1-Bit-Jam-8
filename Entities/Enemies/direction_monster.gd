extends AnimatableBody2D

@export var speed : float = 50.0
@export var direction : Vector2 = Vector2.RIGHT
@export var max_distance : float = 100.0

var start_position : Vector2

func _ready() -> void:
	$AnimatedSprite2D.play()
	start_position = global_position
	direction = direction.normalized()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction * speed * delta
	
	if global_position.distance_to(start_position) >= max_distance:
		global_position = start_position
