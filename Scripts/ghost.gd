extends CharacterBody2D

# bad bad never do this
# do as i say not as i do
@onready var player = get_parent().get_node("Player")

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
	if player != null:
		var direction = (player.global_position - global_position).normalized()
		velocity = velocity.move_toward(direction * 50, 200 * delta)
	move_and_slide()

func _on_hurtbox_area_entered(area):
	velocity = area.knockback_vector * 100
	hurt()
