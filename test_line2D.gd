extends Node2D

@onready var line_2d: Line2D = $Line2D

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
		var temp_pos: Vector2 = position
		position = get_local_mouse_position()
		line_2d.add_point(temp_pos - position)
		line_2d.add_point(temp_pos)
