extends Node2D

var option = 0

func _ready():
	pass

func _process(delta):
	
	if Input.is_action_just_pressed("ui_down"):
		option += 1
		
	if Input.is_action_just_pressed("ui_up"):
		option -= 1
		
	if option < 0:
		option = $itens.get_child_count() - 1
		
	if option > $itens.get_child_count() - 1:
		option = 0
		
		
	if Input.is_action_just_pressed("ui_accept"):
		match option:
			0:
				get_tree().change_scene("res://Scenes/game.tscn")
				
			1:
				get_tree().quit()
		
		
	$arrow.global_position = $itens.get_child(option).global_position + Vector2(-13, 8)
