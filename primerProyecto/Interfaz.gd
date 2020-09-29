extends CanvasLayer
signal iniciar_juego

func mostrar(texto):
	$Mensaje.text = texto
	$Mensaje.show()
	$MensajeTimer.start()

func gameOver():
	mostrar("Derrota")
	yield($MensajeTimer, "timeout") #no se va a activar hasta q se active el nodo
	$BotonJugar.show()
	$Mensaje.text = "X en el espacio"
	$Mensaje.show()

func updateScore(puntos):
	$ScoreLabel.text = str(puntos)

func _on_MensajeTimer_timeout():
	$Mensaje.hide()

func _on_BotonJugar_pressed():
	$MusicaBoton.play()
	$BotonJugar.hide()
	emit_signal("iniciar_juego")
