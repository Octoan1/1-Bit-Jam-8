extends Node2D

@onready var start_menu: Control = $UI/StartMenu
@onready var death_menu: Control = $UI/DeathMenu
@onready var end_screen: Control = $UI/EndScreen
@onready var player: CharacterBody2D = $Player
@onready var end_monster: StaticBody2D = $EnemyContainer/EndMonster
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var background: TileMapLayer = $Tilemap/Background
var is_mute: bool = false
var default
@onready var menu_open: AudioStreamPlayer = $MenuOpen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	start_menu.start_game.connect(_on_game_start)
	end_monster.end_game.connect(_on_game_end)
	player.died.connect(_on_player_death)
	default = audio_stream_player.volume_db
	background.show()


func _on_game_start() -> void:
	get_tree().paused = false
	
func _on_game_end() -> void:
	get_tree().paused = true
	await get_tree().create_timer(2.0).timeout
	menu_open.play()
	end_screen.show()

func _on_player_death() -> void:
	get_tree().paused = true
	#menu_open.play()
	death_menu.show()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mute"):
		is_mute = !is_mute
		
		if not is_mute:
			audio_stream_player.volume_db = -80.0
		else:
			audio_stream_player.volume_db = default 
			
	#elif event.is_action_pressed("lower_volume"):
		#audio_stream_player.volume_db -= 10.0
	#elif event.is_action_pressed("raise_volume"):
		#audio_stream_player.volume_db += 5.0
