extends Spatial

var curent_vehicle : int = 0

func _ready():
	Events.emit_signal('vehicle_activated', get_tree().get_nodes_in_group('veiculos')[curent_vehicle])


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("change_vehicle"):
		curent_vehicle += 1
		if curent_vehicle >= get_tree().get_nodes_in_group('veiculos').size():
			curent_vehicle = 0
		
		Events.emit_signal('vehicle_activated', get_tree().get_nodes_in_group('veiculos')[curent_vehicle])
