extends RigidBody2D
export (int) var velocidadMinima
export (int) var velocidadMaxima
var tipoRoca = ("roca")

func _ready():
	$AnimatedSprite.animation = tipoRoca


func _on_Visibilidad_screen_exited():
	queue_free()
