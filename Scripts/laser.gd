extends Node2D

var PRE_EXPLOSION = preload("res://Scenes/mini_explosion.tscn")

var vel = 200

func _ready():
	pass


func _process(delta):
	translate(Vector2(0, -1) * vel * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_area_entered(area):
	var e = PRE_EXPLOSION.instance()
	get_parent().add_child(e)
	e.global_position = global_position
	queue_free()
