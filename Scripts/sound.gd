extends Node2D

@onready var player = $AudioStreamPlayer

func play(sound: AudioStream):
	player.stream = sound
	player.play()

func _on_audio_stream_player_finished():
	queue_free()
