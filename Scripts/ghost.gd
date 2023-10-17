extends CharacterBody2D

# export a reference to the character
# drag the Player node in the scene view to the 'Player' field in the ghost's inspector
# dont hardcode a reference, its bad
@export var player: CharacterBody2D

var health: int = 2

@onready var audioplayer = preload("res://Scenes/sound.tscn")
@onready var hurtsound = preload("res://Assets/sounds/footstep_snow_004.ogg")
@onready var diesound = preload("res://Assets/sounds/footstep_snow_001.ogg")

func hurt(): 
	var inst = audioplayer.instantiate()
	get_tree().get_root().add_child(inst)
	# reduce health
	# then check if health is 0, call die
	# also play sounds, use inst.play(soundname)

func die():
	queue_free()

func _physics_process(delta):
	# if you have time, add ghost states (idle, wander, chase)
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * 50, 200 * delta)
	move_and_slide()

func _on_hurtbox_area_entered(area):
	velocity = area.knockback_vector * 100
	hurt()
