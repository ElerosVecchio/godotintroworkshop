extends Node2D

@export var nextScene: PackedScene

func _on_area_2d_body_entered(_body):
	# change the scene to nextScene
