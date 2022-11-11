extends Node2D

const SERCOMM = preload('res://bin/GDsercomm.gdns')
onready var PORT = SERCOMM.new()

var endline= "\n"


func _ready():
	PORT.open('COM8', 9600, 1000)


func _process(_delta):
	if PORT.get_available() > 0:
		for teste in range(PORT.get_available()):
			#print(PORT.read())
			pass
	
	readline(PORT)


func readline(port): 
	if !port.has_method("read"): # to avoid problems
		return "NOT A PORT"
	var cho=""
	var chango=""
	while(cho!=endline):
		cho=port.read()
		if typeof(cho)==TYPE_STRING:
			if cho!=endline:
				chango+=cho
		else:
			break
	
	if chango!="":
		print(chango)
		pass
	return chango


func _on_CheckButton_toggled(button_pressed):
	if button_pressed:
		PORT.write(' 180')
	else:
		PORT.write(' 0')


func _on_HSlider_value_changed(value):
	PORT.write(' ' + str(value))
