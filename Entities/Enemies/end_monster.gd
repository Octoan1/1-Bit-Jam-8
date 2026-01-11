extends StaticBody2D

signal end_game

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var player_path: NodePath
var player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_node_or_null(player_path)
	if not player:
		print("EndMonster missing player")

func _on_area_2d_body_entered(body: Node2D) -> void:
	print(body.name, " won??")
	player.can_move = false
	await get_tree().create_timer(1.2).timeout
	player.hide()
	animated_sprite.animation = "close_mouth"
	
	end_game.emit()
