extends CharacterBody2D


var direction : Vector2
@onready var acceleration: int = 10
@onready var max_speed = 250.0 # estaba en 200
var rotacion_aceleracion = 2
var rotation_speed: int = 2
const ROTACION_MAXIMA: int = 250
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var brazo_Derecho: AnimatedSprite2D = $brazoD
@onready var brazo_izquierdo: AnimatedSprite2D = $brazoIZ

var rota: bool = false
var giro_d: bool = false 
var giro_iz: bool = false
var sangre: float = 0.5 

func _process(delta) -> void: 
	
# ---------------| INICIO: CONTROL DE EVENTOS DE ROTACION |--------------#

	if Input.is_action_just_pressed("LEFT"):
		$rotacion.start()
		giro_iz = true
	
	if Input.is_action_just_pressed("RIGHT"):
		$rotacion.start()
		giro_d = true
	
	if Input.is_action_just_released("LEFT"):
		giro_iz = false
		rota = false
		$rotacion.stop()
	
	if Input.is_action_just_released("RIGHT"):
		giro_d =false
		rota = false
		$rotacion.stop()
		
# ---------------| FIN: CONTROL DE EVENTOS DE ROTACION |--------------#
		

func _physics_process(delta: float) -> void:
	
	var input_vector := Vector2(0, Input.get_axis("UP","DOWN")) # Devuelve un vector entre -1 y 1
	velocity += input_vector.rotated(rotation) * acceleration/4
	velocity = velocity.limit_length(max_speed) #Esto no permite que se siga sumando a la de la nave 
	
	if Input.is_action_pressed("LEFT") and rota: 
		if rotation_speed > -ROTACION_MAXIMA:
			rotation_speed -= rotacion_aceleracion 
		rotate(deg_to_rad(rotation_speed * delta)) 
		print(rotation_speed)
		
	if Input.is_action_pressed("RIGHT") and rota:
		if rotation_speed < ROTACION_MAXIMA:
			rotation_speed += rotacion_aceleracion 
		rotate(deg_to_rad(rotation_speed * delta)) 
		print(rotation_speed)
	
	if rotation_speed != 0 and !rota: # desaceleracion del giro
		if rotation_speed < 0:
			rotation_speed += rotacion_aceleracion*2
		else:
			rotation_speed -= rotacion_aceleracion*2
			
		if rotation_speed == 2: # este fragmento solo evita el loop siempre y cuando la aceleracion de rotacion tega por final numero par
			rotation_speed = 0
		rotate(deg_to_rad(rotation_speed * delta))
		print(rotation_speed)

	
	if Input.is_action_pressed("SPACE"):
		#Tiene que hacer un boost que haga que se mueva rápido en una dirección
		$dash.start()
		max_speed = 600
		print(max_speed)
		velocity += input_vector.rotated(rotation) * 15
	
	if input_vector.y != 0:#Esto hace que vaya desacelerando de a poco en incremento de 3.
		if sangre < 1:
			sangre += 0.04
		
		animated_sprite_2d.play("walk")
		brazo_Derecho.play("giro") if giro_iz else brazo_Derecho.play("walk")
		brazo_izquierdo.play("giro") if giro_d else brazo_izquierdo.play("walk")
		$GPUParticles2D.speed_scale = 1.0
		$GPUParticles2D.modulate = Color(1,1,1,sangre)
		
	else:
		
		animated_sprite_2d.play("default")
		brazo_Derecho.play("giro") if giro_iz else brazo_Derecho.play("default")
		brazo_izquierdo.play("giro") if giro_d else brazo_izquierdo.play("default")
		velocity = velocity.move_toward(Vector2.ZERO, 3) #aca decia 30
		$GPUParticles2D.speed_scale = 0.0
		
		if sangre > 0:
			sangre -= 0.04
		else:
			$GPUParticles2D.restart() 
		$GPUParticles2D.modulate = Color(1,1,1,sangre)
	
	move_and_slide()


func _on_rotacion_timeout() -> void: # timer para que tarde un toque en arrancar a girar
	rota = true


func _on_dash_timeout() -> void: #timer para cambiar el maximo de velocidad al "pisar" charco de sangre (por ahora apretar barra)
	var max_speed = 250.0
	print(max_speed)
