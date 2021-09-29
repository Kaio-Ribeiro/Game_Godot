extends Node2D

export(NodePath) var ship

func _ready():
	if ship:
		ship = get_node(ship)
	else:
		set_process(false)

func _process(delta):
	global_position.x = (ship.global_position.x - 80) * 0.002 * -160
