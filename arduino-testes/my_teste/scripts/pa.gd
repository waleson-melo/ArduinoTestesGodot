extends SliderJoint

onready var empilhadeira : VehicleBody = get_parent().get_node("empilhadeira")

var lower_distance_limit : float = -1
var upper_distance_limit : float = 1.5
var pa : float = 0


func _ready() -> void:
	# warning-ignore:return_value_discarded
	Events.connect('vehicle_activated', self, '_ativar_acessorio')
	set_process(false)


func _process(delta) -> void:
	pa = (Input.get_action_strength("pa_up") - Input.get_action_strength("pa_down"))
	
	if pa != 0:
		if pa > 0 and get_param(PARAM_LINEAR_LIMIT_UPPER) < upper_distance_limit:
			var upper = get_param(PARAM_LINEAR_LIMIT_LOWER) + delta
			set_param(PARAM_LINEAR_LIMIT_UPPER, upper)
			set_param(PARAM_LINEAR_LIMIT_LOWER, upper)
		elif pa < 0 and get_param(PARAM_LINEAR_LIMIT_LOWER) > lower_distance_limit:
			var lower = get_param(PARAM_LINEAR_LIMIT_LOWER) - delta
			set_param(PARAM_LINEAR_LIMIT_LOWER, lower)
			set_param(PARAM_LINEAR_LIMIT_UPPER, lower)


# Conectado ao sinal veiculo_selecionado que vem de vehicle
func _ativar_acessorio(veiculo : VehicleBody) -> void:
	set_process(false)
	
	if empilhadeira.get_instance_id() == veiculo.get_instance_id():
		set_process(true)
