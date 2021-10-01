extends Node2D

const PRE_ASTEROID = preload("res://Scenes/asteroid.tscn")
const PRE_EXPLOSION = preload("res://Scenes/explosion.tscn")

export(NodePath) var ship

func _ready():
	restartTimer()

func _process(delta):
	pass


func _on_spawn_timer_timeout():
	var ast = create_asteroid()
	add_child(ast)
	ast.global_position = Vector2(rand_range(40, 120), -60)
	restartTimer()

func restartTimer():
	$spawn_timer.wait_time = rand_range(.5, 1)
	$spawn_timer.start()

func on_asteroid_destroyed(ast):
	if ast.chosen >= 3:
		for a in range(2):
			var new_ast = create_asteroid()
			new_ast.chosen = (randi() % 2) + 1
			add_child(new_ast)
			new_ast.global_position = ast.global_position
	get_tree().call_group("hud", "asteroid_destroyed", ast)
	var e = PRE_EXPLOSION.instance()
	add_child(e)
	e.global_position = ast.global_position

func create_asteroid():
	var ast = PRE_ASTEROID.instance()
	ast.connect("destroyed", self, "on_asteroid_destroyed")
	return ast
