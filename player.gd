extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var pivot: Node2D = $Pivot

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -200.0
@export var CUT_JUMP_VELOCITY = -10


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 0.9 * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump"): #and is_on_floor():
		jump()
	if Input.is_action_just_released("jump"):
		cut_jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : float = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.flip_h = !(direction > 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var mouse_pos = get_global_mouse_position()
	pivot.look_at(mouse_pos)

	move_and_slide()

func jump() -> void:
	self.velocity.y = JUMP_VELOCITY

func cut_jump() -> void:
	# When the jump is going upwards cut its velocity
	if self.velocity.y < CUT_JUMP_VELOCITY:
		self.velocity.y = CUT_JUMP_VELOCITY
