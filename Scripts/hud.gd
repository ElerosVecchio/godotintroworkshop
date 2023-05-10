extends Control

@onready var healthbar = $ProgressBar

func _ready():
	var player = get_parent().get_node("Player")
	# connect to the player's player_hurt signal

func set_health(val):
	healthbar.value = val * 100
