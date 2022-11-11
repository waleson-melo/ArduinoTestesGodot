extends Generic6DOFJoint

onready var colheitadeira : VehicleBody = get_parent().get_node("colheitadeira")

var poste : float = 0


func _ready() -> void:
	# warning-ignore:return_value_discarded
	Events.connect('vehicle_activated', self, '_ativar_acessorio')


func _process(delta: float) -> void:
	poste = Input.get_action_strength("pa_up") - Input.get_action_strength("pa_down")
	
	if poste != 0:
		if poste > 0 and get_param_y(PARAM_ANGULAR_UPPER_LIMIT) < 1.6:
			set_param_y(PARAM_ANGULAR_UPPER_LIMIT, get_param_y(PARAM_ANGULAR_UPPER_LIMIT) + delta)
			set_param_y(PARAM_ANGULAR_LOWER_LIMIT, get_param_y(PARAM_ANGULAR_LOWER_LIMIT) + delta)
		elif poste < 0 and get_param_y(PARAM_ANGULAR_UPPER_LIMIT) > 0:
			set_param_y(PARAM_ANGULAR_LOWER_LIMIT, get_param_y(PARAM_ANGULAR_LOWER_LIMIT) - delta)
			set_param_y(PARAM_ANGULAR_UPPER_LIMIT, get_param_y(PARAM_ANGULAR_UPPER_LIMIT) - delta)


func _ativar_acessorio(vehicle : VehicleBody) -> void:
	set_process(false)
	
	if vehicle.get_instance_id() == colheitadeira.get_instance_id():
		set_process(true)
