extends CharacterBody2D

signal died

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var pivot: Node2D = $Pivot

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -200.0
@export var CUT_JUMP_VELOCITY = -10
var vel_storage : float = 0
var can_jump : bool = true
var gravity
var can_move : bool = true
@onready var jump_progress_bar: TextureProgressBar = $JumpProgressBar
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $FootStepAudio
@onready var foot_step_timer: Timer = $FootStep
@onready var jump_audio: AudioStreamPlayer2D = $JumpAudio
var pitch_default
@onready var death_audio: AudioStreamPlayer2D = $DeathAudio


func _ready() -> void:
	pitch_default = audio_stream_player_2d.pitch_scale

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * 0.5 * delta

	
	# Handle jump.
	jump_progress_bar.value = (vel_storage / JUMP_VELOCITY) * 100.0 # get percentage of jump to full
	if is_on_floor():
		can_jump = true
		
	if not is_on_floor() and can_jump and $CoyoteTimer.is_stopped():
		$CoyoteTimer.start()
	
	if Input.is_action_pressed("jump") and can_jump:
		add_jump()
		#print(vel_storage)
	if Input.is_action_just_released("jump") and can_jump:
		var strength : float = abs(vel_storage) / 200.0
		jump_audio.volume_db = lerp(-20.0, 5.0, strength)
		jump_audio.play()

		jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction : float = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		sprite.play("walk")
		sprite.flip_h = !(direction > 0)
		if foot_step_timer.is_stopped():
			foot_step_timer.start()
		
	else:
		sprite.play("default")
		velocity.x = move_toward(velocity.x, 0, SPEED)
		foot_step_timer.stop()
		
	var mouse_pos = get_global_mouse_position()
	pivot.look_at(mouse_pos)

	if not can_move:
		velocity.x = 0

	move_and_slide()

func jump() -> void:
	self.velocity.y = vel_storage
	vel_storage = 0
	can_jump = false
	jump_progress_bar.value = 0

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
	vel_storage = 0


func _on_hurtbox_component_damaged() -> void:
	print("player died")
	death_audio.play()
	died.emit()
	


func _on_foot_step_timeout() -> void:
	audio_stream_player_2d.play()
	audio_stream_player_2d.pitch_scale = pitch_default + 1 * randf()
