extends Control

signal start_game()

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = true


func _on_quit_button_pressed() -> void:
	audio_stream_player.play()
	get_tree().quit()

func _on_play_button_pressed() -> void:
	audio_stream_player.play()
	start_game.emit()
	self.hide()


func _on_play_button_mouse_entered() -> void:
	audio_stream_player_2.play()


func _on_quit_button_mouse_entered() -> void:
	audio_stream_player_2.play()
