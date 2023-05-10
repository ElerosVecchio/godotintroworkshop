extends CharacterBody2D

signal player_hurt(val)

var target_velocity: Vector2 = Vector2.ZERO

@onready var animplayer = $AnimationPlayer
@onready var dagger = preload("res://Scenes/knife.tscn")
@onready var invulntimer = $invulntimer

var max_health: float = 3.0
var current_health: float = max_health
var invuln: bool = false

# play with these values
# see how it changes movement
const SPEED: int = 150
const ACCELERATION: int = 500

func _physics_process(delta):
	var direction: Vector2 = Vector2.ZERO
	
	direction.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	direction.y = Input.get_action_strength("backward") - Input.get_action_strength("forward")
	direction = direction.normalized()
	
	if direction != Vector2.ZERO:
		target_velocity = target_velocity.move_toward(direction * SPEED, ACCELERATION * delta)
		animplayer.play("walk")
	else:
		target_velocity = target_velocity.move_toward(Vector2.ZERO, ACCELERATION * delta)
		animplayer.play("idle")
	
	velocity = target_velocity
	move_and_slide()

func _input(event):
	if event is InputEventKey:
		if event.is_action_pressed("pause"):
			get_tree().quit()
		if event.is_action_pressed("attack_up"):
			throw_dagger(Vector2.UP)
		elif event.is_action_pressed("attack_down"):
			throw_dagger(Vector2.DOWN)
		elif event.is_action_pressed("attack_left"):
			throw_dagger(Vector2.LEFT)
		elif event.is_action_pressed("attack_right"):
			throw_dagger(Vector2.RIGHT)

func throw_dagger(direction: Vector2):
	var inst = dagger.instantiate()
	get_tree().get_root().add_child(inst)
	inst.global_position = global_position + (direction * 15)
	inst.setup(direction)

func hurt():
	if invuln:
		return
	invuln = true
	invulntimer.start()
	current_health -= 1
	player_hurt.emit(current_health / max_health)
	if current_health <= 0:
		die()

func die():
	queue_free()

func _on_invulntimer_timeout():
	invuln = false
