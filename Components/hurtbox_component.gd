extends Area2D
class_name HurtboxComponent

signal damaged()

func _ready() -> void:
	self.monitoring = false
	self.monitorable = true


func damage():
	damaged.emit()
