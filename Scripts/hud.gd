extends Control

@onready var healthbar = $ProgressBar

func _ready():
	var player = get_parent().get_node("Player")
	# connect set_health to the player's player_hurt signal

func set_health(val):
	# set health bar value to val * 100
