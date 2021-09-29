extends Sprite

export(NodePath) var ship

var time = 0.0

func _ready():
	if ship:
		ship = get_node(ship)
	else:
		set_process(false)

func _process(delta):
	time += delta
	material.set_shader_param("des", (ship.global_position.x - 80) * 0.002)
	material.set_shader_param("time", time)
	
