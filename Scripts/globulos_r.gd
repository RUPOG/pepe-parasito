extends CharacterBody2D

# El globulo rojo se va mover aleatoriamente hasta que se le acerque lo sufgiciente el personaje
# en esee momento se intentará escapar.

@onready var pos_personaje: Vector2
@onready var rango_escape: Area2D = $RangoEscape # Cuando el ersonaje entra en este area se escapa
@onready var en_riesgo:bool = false # auxiliar
@onready var dir_random: Vector2 = Vector2(randi_range(-2,2),randi_range(-2,2))# la direccion
#aleatoria en la cual se movera
@onready var timer_direccion: Timer = $TimerDireccion # Timer que hace que cambie de direccion en la 
#que se estaba moviendo el globulo rojo

var speed: int = 70

func _ready() -> void:
	timer_direccion.connect("timeout",on_timeout) 

func _physics_process(delta: float) -> void:
	#Si esta en risgo intentará escaparse del personaje. De lo contrario se movera aleatoriamente
	if en_riesgo == true:
		var dir = -(pos_personaje - global_position).normalized()
		move_and_collide(dir * (speed * 2)  * delta)
		print(en_riesgo)
	elif en_riesgo == false:
		move_and_collide(dir_random * speed * delta)

func _on_rango_escape_body_entered(body: Node2D) -> void:
	if body:
		en_riesgo = true
		pos_personaje = body.global_position

func _on_rango_escape_body_exited(body: Node2D) -> void:
	en_riesgo = false
	pos_personaje = Vector2.ZERO

func on_timeout() -> void:
	#Utilizado para mover aleatoriamente,
	dir_random = Vector2(randi_range(-2,2),randi_range(-2,2))
