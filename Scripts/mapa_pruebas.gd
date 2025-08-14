extends Node2D

#El mapa ademas de otras cosas que habrá que agregarle se encarga de enviarle a los globulos blancos 
#donde se encuentra el personaje, para que lo sigan constantemente.

signal enviar_posicion_player(pos_personaje)

@onready var emisor_posicion: Timer = $EmisorPosicion # Se utiliza para ir enviando
#cada tanto la posicion del personaje a los globulos
@onready var personaje: Node2D = $Personaje

var posicion_player: Vector2 # esto es lo que se enviara

func _ready() -> void:
	emisor_posicion.connect("timeout",on_timeout)

func on_timeout() ->void:
	#cuando termina el timer se chequea que haya una instancia de personaje
	#y luego se propaga hacia abajo la posicion de este.
	if personaje:
		posicion_player = personaje.character.global_position
		enviar_posicion_player.emit(posicion_player)
