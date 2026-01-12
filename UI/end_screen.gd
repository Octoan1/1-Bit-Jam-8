extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2

func _ready() -> void:
	self.visible = false


func _on_retry_button_pressed() -> void:
	audio_stream_player.play()
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_quit_button_pressed() -> void:
	audio_stream_player.play()
	get_tree().quit()


func _on_retry_button_mouse_entered() -> void:
	audio_stream_player_2.play()


func _on_quit_button_mouse_entered() -> void:
	audio_stream_player_2.play()
