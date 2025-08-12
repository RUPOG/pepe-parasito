extends Node2D


@export var bala: PackedScene = preload("res://Escenas/disparo.tscn")

func _process(delta) -> void: 
	
	if Input.is_action_just_pressed("disparoDerecho"):
		disparar(true)
		
	if Input.is_action_just_pressed("disparoIzquierdo"):
		disparar(false)

func disparar(derecha):
	if derecha:
		var disparo = bala.instantiate() as Area2D
		disparo.z_index = -1
		disparo.global_position = $Character/gusano_iz.global_position
		disparo.global_rotation = $Character/gusano_iz.global_rotation
		get_tree().current_scene.add_child(disparo)	
	else:
		var disparo = bala.instantiate() as Area2D
		disparo.z_index = -1
		disparo.global_position = $Character/gusano_der.global_position
		disparo.global_rotation = $Character/gusano_der.global_rotation
		disparo.scale.x = -1
		get_tree().current_scene.add_child(disparo)	 
