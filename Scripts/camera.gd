extends Camera2D

var time = 0
var force = 0

func _ready():
	pass

func _process(delta):
	if force > 0:
		time += delta * 100
		global_position = Vector2(force, force).rotated(time)
		force = lerp(force, 0, .1)
	
	if Input.is_action_just_pressed("ui_cancel"):
		force = 2
		
	
func shake(v):
	force += v
