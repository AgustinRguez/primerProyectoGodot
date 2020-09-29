extends Area2D
export (int) var velocidad
var movimiento = Vector2() 
var limitePantalla
signal golpeRecibido #signal son eventos

func _ready():
	hide()
	limitePantalla = get_viewport_rect().size #evito q el pj salga de pantalla y se adapte al size
func _process(delta): # delta velocidad real q la pc quiere llevar
	
	movimiento = Vector2() # reinicia los valores para permitir frenarlo
	
	if Input.is_action_pressed("ui_right"): #input es cuando tocas el teclado o botones, leido es: si estoy tocando la tecla de la derecha q pase..
		movimiento.x += 1
	if Input.is_action_pressed("ui_left"):
		movimiento.x -= 1
	if Input.is_action_pressed("ui_up"):
		movimiento.y -= 1
	if Input.is_action_pressed("ui_down"):
		movimiento.y += 1
		
	if movimiento.length() > 0:#verificar si se mueve
		movimiento = movimiento.normalized() * velocidad #normalizar la velocidad
		
	position += movimiento*delta # actualiza las posiciones x e y del nodo
	position.x = clamp(position.x,0,limitePantalla.x)
	position.y = clamp(position.y,0,limitePantalla.y)
	
	if movimiento.x > 0:
		$AnimatedSprite.animation = "Adelante"
		$AnimatedSprite.flip_h = movimiento.x < 0
	elif (movimiento.y < 0 || movimiento.x < 0) || (movimiento.y < 0 && movimiento.x < 0):
		$AnimatedSprite.animation = "Frente"
		$AnimatedSprite.animation = "Adelante"
		$AnimatedSprite.flip_h = movimiento.x < 0 #flip hace de espejo
	else:
		$AnimatedSprite.animation = "Frente"

func _on_Player_body_entered(body): # cuando haya colision con cuerpo
	hide()
	emit_signal("golpeRecibido")
	$CollisionShape2D.disabled = true
	
func inicio(posicionParametro): # inicia el juego
	position = posicionParametro
	show()
	$CollisionShape2D.disabled = false
	
	
	
	
