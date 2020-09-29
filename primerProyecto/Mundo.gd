extends Node2D
export (PackedScene) var roca
var score

func _ready():
	randomize() #patron distinto
	
func nuevoJuego():
	score = 0
	$Player.inicio($PosicionInicio.position) # posicion inicio de pj
	$IniciarTimer.start()
	$Interfaz.mostrar("Ready")
	$Ready.play()
	$Interfaz.updateScore(score)
	
func gameOver():
	$ScoreTimer.stop()
	$RocaTimer.stop()
	$Interfaz.gameOver()
	$Muerte.play()
	$MusicaFondo.stop()

func _on_IniciarTimer_timeout():
	$MusicaFondo.play()
	$ScoreTimer.start()
	$RocaTimer.start()

func _on_ScoreTimer_timeout():
	score += 1
	$Interfaz.updateScore(score)

func _on_RocaTimer_timeout():
	#selecciona un lugar aleatorio en el camino/path
	$Camino/posicionRoca.set_offset(randi())
	var R = roca.instance()
	add_child(R)
	
	#seleccionar una direccion
	var direccion = $Camino/posicionRoca.rotation + PI /2
	
	R.position = $Camino/posicionRoca.position # le paso el valor del path a la variable
	
	#direccion de la rotacion
	direccion += rand_range(-PI /4 , PI /4)
	R.rotation = direccion
	R.set_linear_velocity(Vector2(rand_range(R.velocidadMinima,R.velocidadMaxima),0).rotated(direccion))
	
