extends Marker2D


# PARA USAR ESTA ESCENA HAY QUE PONER QUE GLOBULO VA SPAWNEAR A TRAVÉS DEL EDITOR


@export var escena_globulo: PackedScene
signal propagar_señal

@onready var timer: Timer = $Timer


func _ready() -> void:
	setear_timer()
	var padre = get_parent()
	if padre:
		padre.connect("enviar_posicion_player", on_enviar_posicion_player)

func setear_timer() ->void:
	#Da valores aleatorios al timer para que no sean todos iguales
	timer.connect("timeout", on_timeout)
	timer.wait_time = randf_range(3.5, 7.6)
	timer.start()

func on_enviar_posicion_player(pos_personaje) -> void:
	#Propagación señal. que viene del parent
	propagar_señal.emit(pos_personaje)

func instanciar_escena_globulo() -> void:
	var instancia_globulo = escena_globulo.instantiate()
	#Se crea una instancia en memoria para poder meterla en el scene_tree  
	#Acá se conecta la señal que se está propagando desde mapa... 
	if instancia_globulo.has_method("on_propagar_señal"):
		connect("propagar_señal",instancia_globulo.on_propagar_señal.bind())
#Se mete la instancia en el tree
	add_child(instancia_globulo)


func on_timeout() -> void:
	#Cuando termina el timer se crea un globulo
	instanciar_escena_globulo()
