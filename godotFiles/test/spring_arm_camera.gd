extends Node3D

const MOUSE_SENS = 0.25
@onready var spring_arm := $SpringArm3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	spring_arm.margin = 0.01

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * MOUSE_SENS
		rotation.y = wrapf(rotation.y, 0.0, TAU)
		
		rotation_degrees.x -= event.relative.y * MOUSE_SENS
		rotation.x = clamp(rotation.x, -PI/2, PI/4)
	if spring_arm.spring_length <= -1 :
		spring_arm.spring_length += 1
	if spring_arm.spring_length >= 4:
		spring_arm.spring_length -= 1
		#spring_arm.spring_length = clamp(spring_arm.spring_length, -1, 4)
	if event.is_action_pressed("wheel_up"):
		spring_arm.spring_length -= 1
	if event.is_action_pressed("wheel_down"):
		spring_arm.spring_length += 1
	
		
