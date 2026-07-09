extends Node
class_name MovementController

@export var animation_controller : AnimationController
@export var player: CharacterBody3D
@export var camera: PhantomCamera3D
@export var model: Node3D
@export var player_state: PlayerStateComponent

## Movement
@export var speed := 5.0
@export var acceleration := 4.0
@export var jump_speed := 8.0

@export var noclip_speed := 10.0

@export var rotation_lerp_speed := 0.25

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

signal noclip_toggled(state: bool)
var noclip_enabled := false

func _physics_process(delta: float) -> void:
	if player_state.current_state == player_state.PlayerState.BUSY:
		return
	
	if !noclip_enabled:
		player.velocity.y += -gravity * delta
	
	get_move_input(delta)
	
	if noclip_enabled:
		if Input.is_action_pressed("jump"):
			player.velocity.y = jump_speed
		elif Input.is_action_pressed("crouch"):
			player.velocity.y = -jump_speed
	else:
		if Input.is_action_just_pressed("jump") and player.is_on_floor():
			player.velocity.y = jump_speed
	
	player.move_and_slide()

func get_move_input(delta):
	var input = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var dir = Vector3.ZERO
	
	if input.length_squared() > 0.01:
		var cam_basis = camera.global_transform.basis
		var forward = cam_basis.z
		var right = cam_basis.x
		
		forward.y = 0.0
		right.y = 0.0
		forward = forward.normalized()
		right = right.normalized()
		
		dir = (forward * input.y + right * input.x).normalized()
		
		var target_yaw = atan2(dir.x, dir.z)
		model.rotation.y = lerp_angle(model.rotation.y, target_yaw, rotation_lerp_speed)
	
	if noclip_enabled:
		player.velocity = lerp(player.velocity, dir * noclip_speed, acceleration * delta)
	else:
		player.velocity = lerp(player.velocity, dir * speed, acceleration * delta)

func toggle_noclip() -> bool:
	noclip_enabled = !noclip_enabled
	noclip_toggled.emit(noclip_enabled)
	return noclip_enabled
