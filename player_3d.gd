extends CharacterBody3D


@export var speed = 5.5
@export var jump_speed = 4.5

@export var MOUSE_SENSITIVITY : float = 0.25
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D
@onready var ray_cast_3d = $RayCast3D

var mouse_input: bool = false
var mouse_rotation : Vector3
var rotation_input : float
var tilt_input : float
var player_rotation : Vector3
var camera_rotation : Vector3

var can_move : bool = true

func _unhandled_input(event):
	mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	
	if mouse_input:
		rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		tilt_input = -event.relative.y * MOUSE_SENSITIVITY
		print(Vector2(rotation_input, tilt_input))
		
	elif event.is_action_pressed("ui_interact"):
		# This is just a test. Press "E" anywhere.
		print("Mistress talking")
		var resource = load("res://Dialogue/mistress_dialogue.dialogue")
		var dialogue_line = await DialogueManager.get_next_dialogue_line(resource, "start")
		DialogueManager.show_dialogue_balloon(resource)
		
	

func _update_camera(delta):
	
	mouse_rotation.x += tilt_input * delta
	mouse_rotation.x = clamp(mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	mouse_rotation.y += rotation_input * delta
	
	player_rotation = Vector3(0.0, mouse_rotation.y, 0.0)
	camera_rotation = Vector3(mouse_rotation.x, 0.0, 0.0)
	
	CAMERA_CONTROLLER.transform.basis = Basis.from_euler(camera_rotation)
	CAMERA_CONTROLLER.rotation.z = 0.0
	# Turn raycast towards movement direction
	if $RayCast3D:
		var camera_global_transform = CAMERA_CONTROLLER.global_transform
		var raycast_origin = camera_global_transform.origin
		var raycast_target = raycast_origin + camera_global_transform.basis.z * -2.0 # forward in -Z
		$RayCast3D.global_position = raycast_origin
		$RayCast3D.target_position = raycast_target - raycast_origin  # Set local target direction
	
	global_transform.basis = Basis.from_euler(player_rotation)
	
	rotation_input = 0.0
	tilt_input = 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED




func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	_update_camera(delta)
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
	
	
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	
