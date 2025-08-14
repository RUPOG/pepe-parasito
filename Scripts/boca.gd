extends Node2D

@onready var line_2d: Line2D = $Line2D
@onready var sprite_2d: Sprite2D = $gancho
var velocidad_lengua: float = 50 
var area_mause = false

func _ready() -> void:
	self.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED


func _process(delta: float) -> void:
	#si is_travelling se puede modificar la posicion, si no vuelve 
	# de a poco al origen
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#obtener direccion y normalizar vector
		#incrementar cantidad de puntos paulatinamente hasta llegar a 
		#posicion deseada o al máximo(máximo se consigue con area2D.)
		#el incremento utiliza await y lambda
		line_2d.clear_points()
		var base_pos: Vector2 = Vector2(0,0)
		#sprite_2d.position = get_local_mouse_position()
		sprite_2d.position = sprite_2d.position.move_toward(get_local_mouse_position(), velocidad_lengua)
		line_2d.add_point(base_pos)
		line_2d.add_point(sprite_2d.position - base_pos)
	else:
		sprite_2d.position = sprite_2d.position.move_toward(Vector2.ZERO, velocidad_lengua)
		line_2d.remove_point(line_2d.get_point_count()-1)
		line_2d.add_point(sprite_2d.position )
		
		
	#-------------| CONTROL BOCA |------------#
	
	if abs(sprite_2d.position.x) > 2.0 and abs(sprite_2d.position.y) > 2.0:
		sprite_2d.visible = true
	else :
		sprite_2d.visible = false
	
	if Input.is_action_just_pressed("lengua"):
		$piboteB/boca.play("disparo")

	if sprite_2d.position == Vector2(0,0):
		$piboteB/boca.play("default")
		print(sprite_2d.position)
		
	#if area_mause:
		#$piboteB.look_at(get_global_mouse_position())
	$piboteB.look_at(get_global_mouse_position())
	#-----------------------------------------#
	


func _on_area_2d_mouse_entered() -> void:
	area_mause = true


func _on_area_2d_mouse_exited() -> void:
	area_mause = false
