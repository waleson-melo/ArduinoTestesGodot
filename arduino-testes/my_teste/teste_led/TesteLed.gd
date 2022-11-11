extends Node2D

const SERCOMM = preload('res://bin/GDsercomm.gdns')
onready var PORT = SERCOMM.new()


func _ready():
	PORT.open('COM9', 9600, 1000)


func _process(_delta):
	if PORT.get_available() > 0:
		for teste in range(PORT.get_available()):
			print(PORT.read())


func _on_CheckButton_toggled(button_pressed):
	if button_pressed:
		PORT.write('1')
	else:
		PORT.write('0')
