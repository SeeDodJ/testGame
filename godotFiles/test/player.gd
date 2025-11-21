extends CharacterBody3D

#@onready var camera = $springArmSmooth

const SPEED = 3.0
const JUMP_VELOCITY = 4.5
const MOUSE_SENS = 0.5
var xform : Transform3D


# processes things only once when entering the scene
func _ready():
	pass

# makes it do what you write in there once it detects input
func _input(event):
	pass

# this one is making your game close when you hit esc
func _process(delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()

# processes the things written in there 60 times a second
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# makes you go where you look basically
	direction = direction.rotated(Vector3.UP, $springArmSmooth.global_rotation.y)
	
 #align the character to the floor
	if is_on_floor() and input_dir != Vector2(0, 0):
		align_with_floor($RayCast3D.get_collision_normal())
		global_transform = global_transform.interpolate_with(xform, 0.1)
	elif not is_on_floor():
		align_with_floor(Vector3.UP)
		global_transform = global_transform.interpolate_with(xform, 0.1)
		
	
	
	#makes your character move with certain speed
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
#this one speaks for itself
	move_and_slide()

func align_with_floor(floor_normal):
	xform = global_transform
	xform.basis.y = floor_normal
	xform.basis.x = -xform.basis.z.cross(floor_normal)
	xform.basis = xform.basis.orthonormalized()


func _on_fall_zone_body_entered(body: Node3D) -> void:
	get_tree().change_scene_to_file("res://playground.tscn")
