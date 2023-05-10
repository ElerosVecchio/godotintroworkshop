extends Control

@onready var packedScene = preload("res://Scenes/level1.tscn")

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(packedScene)

# add quit button
