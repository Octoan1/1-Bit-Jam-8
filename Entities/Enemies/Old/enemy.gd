@tool
extends CharacterBody2D
class_name Enemy

enum MoveType {
	STILL,
	CHASE_PLAYER,
	FOLLOW_PATH
}

@export var sprite_texture : Texture2D 		
@export var collision_shape : Shape2D
@export var behavior : MoveType = MoveType.STILL
@export var player_path : NodePath

@export var speed : float = 80.0

@onready var player := get_node_or_null(player_path)
@onready var path_follow: PathFollow2D = $PathFollow2D

func _ready() -> void:
	$CollisionShape2D.shape = collision_shape
	$Sprite2D.texture = sprite_texture

func _physics_process(delta: float) -> void:
	$Sprite2D.texture = sprite_texture
	
	match behavior:
		MoveType.STILL:
			velocity = Vector2.ZERO

		MoveType.CHASE_PLAYER:
			if player:
				velocity = (player.global_position - global_position).normalized() * speed

		MoveType.FOLLOW_PATH:
			if path_follow:
				path_follow.progress += speed * delta
				global_position = path_follow.global_position
				return  # skip move_and_slide()
