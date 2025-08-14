extends Node2D

signal dash_sangre

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("personaje"):
		if body.has_method("recibir_dash_sangre"):
			body.recibir_dash_sangre()
