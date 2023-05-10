extends CharacterBody2D

var health: int = 2

func hurt():
	health -= 1
	if health <= 0:
		die()

func die():
	queue_free()

func _physics_process(delta):
	move_and_slide()
	var collision = get_last_slide_collision()
	if collision == null:
		return
	var collider = collision.get_collider()
	if collider.has_method("hurt"):
		collider.hurt()
