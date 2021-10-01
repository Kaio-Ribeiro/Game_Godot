extends Node2D

const PRE_LASER = preload("res://Scenes/laser.tscn")

export var vel = 100.0

var shield = 100.0

onready var shield_size = $shield/Sprite.material.get_shader_param("size")

onready var shape_size = $Area2D/CollisionShape2D.shape.radius

export(NodePath) var lasers

func _ready():
	if lasers:
		lasers = get_node(lasers)
	else:
		lasers = get_parent()


func _process(delta):
	
	var dirX = 0
	var dirY = 0
	
	if Input.is_action_pressed("ui_left"):
		dirX += -1
		
	if Input.is_action_pressed("ui_right"):
		dirX += 1
		
	if Input.is_action_pressed("ui_up"):
		dirY += -1
		
	if Input.is_action_pressed("ui_down"):
		dirY += 1
		
	if Input.is_action_just_pressed("ui_accept"):
		if get_tree().get_nodes_in_group("lasers").size() < 7:
			var laser = PRE_LASER.instance()
			lasers.add_child(laser)
			laser.global_position = $blaster.global_position
		
	translate(Vector2(dirX, dirY) * vel * delta)
	
	global_position.x = clamp(global_position.x, 21, 139)
	global_position.y = clamp(global_position.y, 24, 266)


func _on_Area2D_area_entered(area):
	if area.get_parent().has_method("destroy"):
		area.get_parent().destroy()
		
	get_tree().call_group("camera", "shake", 1)
	shield -= .35
	print(shield)
	print($Area2D/CollisionShape2D.shape.radius)
	$Area2D/CollisionShape2D.shape.radius = shape_size * shield/100.0
	$shield/Sprite.material.set_shader_param("size", shield_size * shield/100.0)


func _on_dead_area_area_entered(area):
	visible = false
	set_process(false)
	get_tree().change_scene("res://Scenes/test_scene.tscn")
