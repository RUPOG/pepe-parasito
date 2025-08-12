extends Area2D


var x: float = 0.0
var frecuencia: float = 2.0
var amplitud: float = 1.5
var velocidad_x: float = 100.0
var aceleracion: float = 1.01

var origen = Vector2.ZERO
var direccion_base = Vector2.RIGHT  # dirección base 
var rotacion_offset = 0.0 # en radianes, podés cambiar este valor para rotar la bala respecto a la tangente

func _ready():
	origen = position
	# direccion base a partir de la rotación inicial, para que pueda salir en ángulo
	direccion_base = -Vector2(cos(rotation), sin(rotation)).normalized()
	$tiempo.start()

func _process(delta) -> void:
	if velocidad_x < 300:
		velocidad_x *= aceleracion

	x += delta * frecuencia * TAU

	var desplazamiento_x = velocidad_x * x / (frecuencia * TAU)  # distancia recorrida en dirección base
	var desplazamiento_y = amplitud * sin(x)  # desplazamiento perpendicular

	# vector perpendicular a la dirección base (rotado 90° ccw)
	var perpendicular = Vector2(-direccion_base.y, direccion_base.x)

	# calculamos posición relativa al origen usando dirección y perpendicular
	position = origen + direccion_base * desplazamiento_x + perpendicular * desplazamiento_y

	# Calculamos la tangente para la rotación: derivada de la posición
	var dx = velocidad_x
	var dy = amplitud * cos(x) * frecuencia * TAU
	var tangente = (direccion_base * dx + perpendicular * dy).normalized()

	rotation = tangente.angle() + rotacion_offset


func _on_tiempo_timeout() -> void:
	queue_free()
