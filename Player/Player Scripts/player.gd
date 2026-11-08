extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

@export var mouse_sens: float = 0.3
@export var TILT_LOWER_LIMIT := deg_to_rad(-90.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(90.0)
@export var camera_controller: Camera3D

var mouse_input: bool = false
var mouse_rotation: Vector3
var rotation_value: float
var tilt_value: float
var player_rotation: Vector3
var camera_rotation: Vector3

@onready var anim_player: AnimationPlayer = $AnimationPlayer

@onready var interaction_cast: ShapeCast3D = $Camera_Controller/Camera3D/Interaction_ShapeCast
@onready var hand: Marker3D = $Camera_Controller/Camera3D/Hand

var held_item: RigidBody3D
var used_machine: StaticBody3D
var item_collision_shape: CollisionShape3D


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
		
func _unhandled_input(event: InputEvent) -> void:
	mouse_input = event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	if mouse_input:
		rotation_value = - event.relative.x * mouse_sens
		tilt_value = -event.relative.y * mouse_sens
		

func update_camera(delta):
	mouse_rotation.x += tilt_value * delta
	mouse_rotation.x = clamp(mouse_rotation.x, TILT_LOWER_LIMIT, TILT_UPPER_LIMIT)
	mouse_rotation.y += rotation_value * delta
	
	player_rotation = Vector3(0.0, mouse_rotation.y, 0.0)
	camera_rotation = Vector3(mouse_rotation.x, 0.0, 0.0)
	
	camera_controller.transform.basis = Basis.from_euler(camera_rotation)
	camera_controller.rotation.z = 0.0
	
	global_transform.basis = Basis.from_euler(player_rotation)
	
	rotation_value = 0.0
	tilt_value = 0.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	update_camera(delta)

	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("interact"):
		pickup_item()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func pickup_item():
	for i in interaction_cast.get_collision_count():
		var item = interaction_cast.get_collider(i)
		var machine = interaction_cast.get_collider(i)
		
		if item.is_in_group("Pickable") and held_item == null:
			held_item = item
			var collision = item.get_node("CollisionShape3D")
			
			item.reparent(hand, false)			# Put the item child to Hand
			item.position = Vector3.ZERO		# Change item position to 0/hand
			item.rotation = Vector3.ZERO		# Change item rotation to 0
			item.freeze = true
			collision.disabled = true
		elif item.is_in_group("Pickable") and held_item != null:
			print("Mains pleines")
			return
		elif item.is_in_group("Usable"):
			used_machine = machine
			machine.use_machine(machine)
