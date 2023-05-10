extends CharacterBody2D

const SPEED: int = 500

func setup(direction: Vector2):
	match direction:
		Vector2.UP:
			rotation_degrees = 0
		Vector2.DOWN:
			rotation_degrees = 180
		Vector2.RIGHT:
			rotation_degrees = 90
		Vector2.LEFT:
			rotation_degrees = 270
	velocity = direction * SPEED

func _physics_process(delta):
	move_and_slide()
	var collision = get_last_slide_collision()
	if collision == null:
		return
	var collider = collision.get_collider()
	if collider.has_method("hurt"):
		collider.hurt()
	queue_free()
