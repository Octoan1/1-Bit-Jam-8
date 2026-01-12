extends Node


func _ready() -> void:
	if AudioManager.muted:
			self.volume_db = -80.0
	else:
			self.volume_db = 0 

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("mute"):
		AudioManager.muted = !AudioManager.muted
		
		if AudioManager.muted:
			self.volume_db = -80.0
		else:
			self.volume_db = 0 
