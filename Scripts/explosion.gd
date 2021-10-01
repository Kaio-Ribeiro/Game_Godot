extends Node2D

func _ready():
	$Particles2D.emitting = true
	$sparks.emitting = true


func _process(delta):
	if not $Particles2D.emitting and not $sparks.emitting:
		queue_free()
