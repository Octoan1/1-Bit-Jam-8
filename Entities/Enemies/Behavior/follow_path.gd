extends EnemyBehavior
class_name FollowPath

#@export var path_follow : PathFollow2D

func get_velocity(_enemy, _delta) -> Vector2:
	#path_follow.progress += enemy.speed * delta
	
	return Vector2.ZERO
