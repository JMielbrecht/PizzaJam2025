extends CharacterBody3D


@export var speed = 10
@export var jump_speed = 4.5

@export var MOUSE_SENSITIVITY : float = 0.25
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var CAMERA_CONTROLLER : Camera3D
@onready var ray_cast_3d = $RayCast3D

@export var HUD : Control

var bullet_inst = load("res://Scenes/bullet_3d.tscn")
@onready var bullet_spawn_pos = %BulletSpawnPoint



var mouse_input: bool = false
var mouse_rotation : Vector3
var rotation_input : float
var tilt_input : float
var player_rotation : Vector3
var camera_rotation : Vector3
var current_interactable: Node = null
@onready var hud: Node = $HUD
@export var hud_label: Label

var chamber: int = 6
@onready var chamber_label = HUD.get_node("ChamberCount")

var can_move : bool = true

func _unhandled_input(event):
	mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	
	if current_interactable:
		hud_label.text = "Press E to Interact"
		hud_label.visible = true
		# Show HUD or 3D prompt
		#current_interactable.show_interact_prompt()
	else:
		hud_label.visible = false
		
	if mouse_input:
		rotation_input = -event.relative.x * MOUSE_SENSITIVITY
		tilt_input = -event.relative.y * MOUSE_SENSITIVITY
		
	elif Input.is_action_just_pressed("ui_interact"):
		if current_interactable:
			print("Should start dialogue")
			# This is just a test. Press "E" anywhere.
			current_interactable.start_dialog()

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
	if Input.is_action_pressed("jump") and is_on_floor():
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
	
	
	if chamber > 0:
		if Input.is_action_just_pressed("shoot"):
			var inst = bullet_inst.instantiate()
			inst.position = bullet_spawn_pos.global_position
			inst.transform.basis = bullet_spawn_pos.global_transform.basis
			get_parent().add_child(inst)
			
			chamber -= 1
			chamber_label.text = str(chamber)
	
	else:
		if Input.is_action_just_pressed("reload"):
			chamber = 6
			chamber_label.text = str(chamber)
	
	
	
	
	if Input.is_action_pressed("sprint"):
		speed = 30
	else:
		speed = 6
	
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
