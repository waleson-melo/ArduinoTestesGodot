extends Spatial

const SERCOMM = preload('res://bin/GDsercomm.gdns')
onready var PORT = SERCOMM.new()

var junta = null
var carroca = null
var trator : VehicleBody = null


func _ready() -> void:
	# warning-ignore:return_value_discarded
	Events.connect('vehicle_activated', self, '_ativar_acessorio')
	
	carroca = get_children()[0]
	junta = get_children()[0].get_children()[0]


func _input(_event) -> void:
	if Input.is_action_just_pressed("track") and trator != null:
		PORT.close()
		junta.set_node_b('')
		junta.set_node_a('')


func _ativar_acessorio(vehicle : VehicleBody) -> void:
	set_process_input(false)
	if vehicle.is_in_group('trator'):
		set_process_input(true)


func _on_pino_gancho_body_entered(body) -> void:
	PORT.open('COM9', 9600, 1000)
	PORT.write('1')
	trator = body.get_parent()
	junta.set_node_b(body.get_parent().get_path())
	junta.set_node_a(carroca.get_path())
