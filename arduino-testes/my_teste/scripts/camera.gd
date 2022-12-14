extends Spatial

# Control variables
export var maxPitch : float = 45
export var minPitch : float = -45
export var maxZoom : float = 20
export var minZoom : float = 4
export var zoomStep : float = 2
export var zoomYStep : float = 0.15
export var verticalSensitivity : float = 0.002
export var horizontalSensitivity : float = 0.002
export var camYOffset : float = 4.0
export var camLerpSpeed : float = 16.0

# Private variables
var _camTarget : Spatial = null
var _cam : ClippedCamera
var _curZoom : float = 0.0


func _ready() -> void:
	# warning-ignore:return_value_discarded
	Events.connect('vehicle_activated', self, '_set_vehicle')

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


# Seleciona o veiculo a ser usado
func _set_vehicle(vehicle) -> void:
	_camTarget = get_node(vehicle.get_path())
	_cam = get_node("camera")

	# Setup camera position in rig
	_cam.translate(Vector3(0,camYOffset,maxZoom))
	_curZoom = maxZoom


func _input(event) -> void:
	# Destravar o mouse ou travar
	if Input.is_action_just_pressed("track_mouse"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation_degrees.x = clamp(rotation_degrees.x - event.relative.y * 0.1, -20, 20)
			rotation_degrees.y -= event.relative.x * 0.1

	if event is InputEventMouseMotion:
		# Rotate the rig around the target
		rotate_y(-event.relative.x * horizontalSensitivity)
		rotation.x = clamp(rotation.x - event.relative.y * verticalSensitivity, deg2rad(minPitch), deg2rad(maxPitch))
		orthonormalize()

	if event is InputEventMouseButton:
		# Change zoom level on mouse wheel rotation
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP and _curZoom > minZoom:
				_curZoom -= zoomStep
				camYOffset -= zoomYStep
			if event.button_index == BUTTON_WHEEL_DOWN and _curZoom < maxZoom:
				_curZoom += zoomStep
				camYOffset += zoomYStep


func _physics_process(delta) -> void:
	# zoom the camera accordingly
	_cam.set_translation(_cam.translation.linear_interpolate(Vector3(0,camYOffset,_curZoom),delta * camLerpSpeed))
	# set the position of the rig to follow the target
	set_translation(_camTarget.global_transform.origin)
