extends Node2D

var chosen = 0
var hp = 0
var knock_back = 0
onready var velY = rand_range(30, 200)
onready var velX = rand_range(-50, 50)

signal destroyed(node)

var hps = [
	1,
	1,
	3,
	2,
	2
]

func _ready():
	randomize()
	for a in $asteroids.get_children():
		a.visible = false
		
	if not chosen:
		chosen = (randi() % $asteroids.get_child_count()) + 1
		
	hp = hps[chosen-1]
	
	var node = get_node("asteroids/asteroid-" + str(chosen))
	
	node.visible = true
	
	$Area2D/CollisionShape2D.shape.radius = node.texture.get_width() / 2

func _process(delta):
	translate(Vector2(velX, velY - knock_back) * delta)
	
	if global_position.x > 200:
		global_position.x = -40
		
	if global_position.x < -40:
		global_position.x = 200
		
	if global_position.y > 300:
		global_position.y = -60
		
	if knock_back:
		knock_back = lerp(knock_back, 0, .1)

func _on_Area2D_area_entered(area):
	hp -= 1
	knock_back = 50
	
	if not hp:
		destroy()


func destroy():
	get_tree().call_group("camera", "shake", 1)
	emit_signal("destroyed", self)
	queue_free()
