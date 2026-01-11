extends Node2D

@onready var start_menu: Control = $UI/StartMenu
@onready var death_menu: Control = $UI/DeathMenu
@onready var end_screen: Control = $UI/EndScreen
@onready var player: CharacterBody2D = $Player
@onready var end_monster: StaticBody2D = $EnemyContainer/EndMonster

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	start_menu.start_game.connect(_on_game_start)
	end_monster.end_game.connect(_on_game_end)
	player.died.connect(_on_player_death)


func _on_game_start() -> void:
	get_tree().paused = false
	
func _on_game_end() -> void:
	get_tree().paused = true
	await get_tree().create_timer(2.0).timeout
	end_screen.show()

func _on_player_death() -> void:
	get_tree().paused = true
	death_menu.show()
	
