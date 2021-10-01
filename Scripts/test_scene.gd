extends Node2D

var option = 0

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/start_scene.tscn")
