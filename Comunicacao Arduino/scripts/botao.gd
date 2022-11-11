extends Node


func _ready():
	Serial.connect("apertando", self, "_teste")


func _physics_process(_delta):
	pass


func _teste():
	print("isso é um teste")
