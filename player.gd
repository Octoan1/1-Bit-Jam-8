extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var pivot: Node2D = $Pivot

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -200.0
@export var CUT_JUMP_VELOCITY = -10
var vel_storage := 0
var can_jump : bool = true
var gravity


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	
	# Add the gravity.
	if not is_on_floor():
		print(get_gravity())
		velocity += get_gravity() * 0.6 * delta

	# Handle jump.
	if is_on_floor():
		can_jump = true
		
	if not is_on_floor() and can_jump and $CoyoteTimer.is_stopped():
		$CoyoteTimer.start()
	
	if Input.is_action_pressed("jump") and can_jump:
		add_jump()
		print(vel_storage)
	if Input.is_action_just_released("jump") and can_jump:
		jump()

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
	self.velocity.y = vel_storage
	vel_storage = 0
	can_jump = false

func add_jump() -> void:
	if vel_storage > JUMP_VELOCITY:
		vel_storage -= 4

# === UNUSED ===
func cut_jump() -> void:
	# When the jump is going upwards cut its velocity
	if self.velocity.y < CUT_JUMP_VELOCITY:
		self.velocity.y = CUT_JUMP_VELOCITY
# === === ===

func _on_coyote_timer_timeout() -> void:
	can_jump = false
