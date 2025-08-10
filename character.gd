extends CharacterBody2D


var direction : Vector2
@onready var acceleration: int = 10
@onready var max_speed = 200.0
const ROTATION_SPEED: int = 100
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	
	var input_vector := Vector2(0, Input.get_axis("UP","DOWN")) # Devuelve un vector entre -1 y 1
	velocity += input_vector.rotated(rotation) * acceleration
	velocity = velocity.limit_length(max_speed) #Esto no permite que se siga sumando a la de la nave 
	
	if Input.is_action_pressed("LEFT"):
		rotate(deg_to_rad(-ROTATION_SPEED * delta))
	if Input.is_action_pressed("RIGHT"):
		rotate(deg_to_rad(ROTATION_SPEED * delta))
	
	if Input.is_action_pressed("SPACE"):
		#Tiene que hacer un boost que haga que se mueva rápido en una dirección
		velocity += input_vector.rotated(rotation) * 300
	
	if input_vector.y != 0:#Esto hace que vaya desacelerando de a poco en incremento de 3.
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("default")
		velocity = velocity.move_toward(Vector2.ZERO, 30)
	
	move_and_slide()
