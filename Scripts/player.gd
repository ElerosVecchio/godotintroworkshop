extends CharacterBody2D

signal player_hurt(val)

var target_velocity: Vector2 = Vector2.ZERO

@onready var animplayer = $AnimationPlayer
@onready var dagger = preload("res://Scenes/knife.tscn")
@onready var invulntimer = $invulntimer

@onready var audioplayer = preload("res://Scenes/sound.tscn")
@onready var hurtsound = preload("res://Assets/sounds/footstep_snow_004.ogg")
@onready var diesound = preload("res://Assets/sounds/footstep_snow_001.ogg")

var invuln: bool = false

# play with these values
# see how it changes movement
const SPEED: int = 150
const ACCELERATION: int = 500
var max_health: float = 3.0
var current_health: float = max_health

func _physics_process(delta):
	var direction: Vector2 = Vector2.ZERO
	
	# set the x and y parts of direction using Input.get_action_strength
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
		#check if the attack_dir actions have been pressed (Project > Project Settings > Input Map) for names
		#if yes, throw dagger in that direction

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
	var inst = audioplayer.instantiate()
	get_tree().get_root().add_child(inst)
	# reduce health
	# then check if health is 0, call die
	# also play sounds, use inst.play(soundname)
	# emit the player hurt signal with current_health / max_health

func die():
	get_tree().reload_current_scene()

func _on_invulntimer_timeout():
	invuln = false

func _on_hitbox_area_entered(_area):
	hurt()
