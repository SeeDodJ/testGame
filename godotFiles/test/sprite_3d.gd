extends Sprite3D

var currency = 5
var player_name = "robot"
var hp = 3.5
const SPEED = 2
var x = currency / SPEED
var areClankersBad = true
var key_collected = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("clankers")
	print(addStuff(currency, SPEED))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_input()

func addStuff(z, y):
	var sum = z + y
	return sum

func check_input():
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		rotate_y(deg_to_rad(SPEED))
		rotate_x(deg_to_rad(SPEED))
	else:
		rotate_y(deg_to_rad(-SPEED))
		rotate_x(deg_to_rad(-SPEED))
