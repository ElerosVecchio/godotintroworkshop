extends Control

@onready var healthbar = $ProgressBar

func _ready():
	var player = get_parent().get_node("Player")
	player.player_hurt.connect(set_health)

func set_health(val):
	healthbar.value = val * 100
