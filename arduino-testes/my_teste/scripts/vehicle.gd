extends Spatial

var vehicle : VehicleBody

export var engine_force_value : float = 40
export var STEER_SPEED : float = 1.5
export var STEER_LIMIT : float = 0.9
export var invert_direction : bool = true

var steer_target: float = 0


func _ready() -> void:
	set_process(false)
	# warning-ignore:return_value_discarded
	Events.connect('vehicle_activated', self, '_vehicle_changed')
	
	# Procurando o no VehicleBody e adicionando ao grupo veiculos
	for i in get_children():
		if i.is_class('VehicleBody'):
			vehicle = get_node(i.get_path())
			vehicle.add_to_group('veiculos')
			break


func _vehicle_changed(veiculo):
	if veiculo.get_instance_id() == vehicle.get_instance_id():
		set_process(true)
	else:
		set_process(false)
		vehicle.engine_force = 0


func _process(delta) -> void:
	var fwd_mps : float = vehicle.transform.basis.xform_inv(vehicle.linear_velocity).x

	if invert_direction:
		steer_target = -Input.get_action_strength("turn_left") + Input.get_action_strength("turn_right")
	else:
		steer_target = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")		
	
	steer_target *= STEER_LIMIT

	if Input.is_action_pressed("accelerate") and not Input.is_action_pressed("brake"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		var speed : float = vehicle.linear_velocity.length()
		if speed < 5 and speed != 0:
			vehicle.engine_force = clamp(engine_force_value * 5 / speed, 0, 100)
		else:
			vehicle.engine_force = engine_force_value
	else:
		vehicle.engine_force = 0

	if Input.is_action_pressed("reverse") and not Input.is_action_pressed("brake"):
		# Increase engine force at low speeds to make the initial acceleration faster.
		if fwd_mps >= -1:
			var speed : float = vehicle.linear_velocity.length()
			if speed < 5 and speed != 0:
				vehicle.engine_force = -clamp(engine_force_value * 5 / speed, 0, 100)
			else:
				vehicle.engine_force = -engine_force_value
		else:
			vehicle.brake = 1
	else:
		vehicle.brake = 0.0
	
	if Input.is_action_pressed("brake"):
		vehicle.brake = 2.0

	vehicle.steering = move_toward(vehicle.steering, steer_target, STEER_SPEED * delta)
