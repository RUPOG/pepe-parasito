extends CharacterBody2D

#El globulo blanco sabe todo el timepo en dondese encuentra el personaje y se mueve hacia el.

@onready var pos_personaje: Vector2
var speed: int = 10

func _physics_process(delta: float) -> void:
	# si se quiere agregar un area poner un bool
	if pos_personaje:
		var dir = (pos_personaje - global_position).normalized()
		move_and_collide(dir * speed * delta)

	

func on_propagar_señal(pos_personaje) -> void:
	# pos es la posicion del player que se viene propagando desde el nodo padre(mapa) 
	self.pos_personaje = pos_personaje
