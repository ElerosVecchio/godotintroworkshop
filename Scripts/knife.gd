extends CharacterBody2D

const SPEED: int = 500

@onready var hitbox = $hitbox

func setup(direction: Vector2):
	hitbox.knockback_vector = direction
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

func _physics_process(_delta):
	move_and_slide()
	var collision = get_last_slide_collision()
	if collision == null:
		return
	queue_free()

func _on_hitbox_area_entered(_area):
	queue_free()
