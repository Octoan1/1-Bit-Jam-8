extends Area2D


func _on_area_entered(area: Area2D) -> void:
	var mat : ShaderMaterial = area.get_parent().material
	
	mat.set_shader_parameter("line_thickness", 1.0)
	
	


func _on_area_exited(area: Area2D) -> void:
	var mat : ShaderMaterial = area.get_parent().material
	
	mat.set_shader_parameter("line_thickness", 0.0)
