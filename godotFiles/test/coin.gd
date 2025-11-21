extends Area3D

const ROTSPEED = 2 # number of degrees the coin rotates every frame
@export var hud : CanvasLayer 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROTSPEED))


func _on_body_entered(body: Node3D) -> void:
	Global.coins += 1
	hud.get_node("coinLabel").text = str(Global.coins)
	if Global.coins >= Global.WIN_COND:
		get_tree().change_scene_to_file("res://playground.tscn")
	$AnimationPlayer.play("bounce")
	set_collision_layer_value(3, false)
	set_collision_mask_value(1, false)
	print("you have collected a coin!")
	print(Global.coins)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
