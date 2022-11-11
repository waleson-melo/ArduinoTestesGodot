extends Node


func _ready():
	WebSocket.connect("botao_pressionado", self, "_on_click_down")
	WebSocket.connect("botao_liberado", self, "_on_click_up")


func _on_click_down():
	$CheckButton.set_pressed_no_signal(true)
	_on_CheckButton_toggled(true)


func _on_click_up():
	$CheckButton.set_pressed_no_signal(false)
	_on_CheckButton_toggled(false)


func _on_CheckButton_toggled(button_pressed):
	if button_pressed:
		WebSocket.write_web_socket("ligar\n")
	else:
		WebSocket.write_web_socket("desligar\n")
