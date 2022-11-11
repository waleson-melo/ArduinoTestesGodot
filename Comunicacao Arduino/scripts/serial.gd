extends Node

const SERIAL_RESOURCE = preload("res://bin/GDsercomm.gdns")
var serial_port = SERIAL_RESOURCE.new()

signal apertando(player)


func _ready():
	open_port("COM9")


func _physics_process(_delta):
	var data = read_data()
	if data == "apertando":
		emit_signal("apertando")


func open_port(port, baudrate=500000, timeout=5000):
	return serial_port.open(port, baudrate, timeout)


func close_port():
	serial_port.close()


func read_data():
	var text = ""
	var result_get_available = serial_port.get_available()
	if result_get_available > 0:
		for i in range(result_get_available):
			var cho = serial_port.read()
			
			if typeof(cho) == TYPE_STRING:
				if cho != "\n":
					text += str(cho).strip_edges()
			else:
				break
	
	if text != "":
		print(text)
		
	return text
