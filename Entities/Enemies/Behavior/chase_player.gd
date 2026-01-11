extends EnemyBehavior
class_name ChasePlayer

@export var player_path: NodePath

func get_velocity(enemy, _delta) -> Vector2:
	var player = enemy.get_node(player_path)
	var direction = (player.global_position - enemy.global_position).normalized()
	
	return direction * enemy.speed
