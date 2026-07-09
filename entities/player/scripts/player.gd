extends CharacterBody3D
class_name Player

var health_component : HealthComponent
var stamina_component: StaminaComponent

var movement_controller : MovementController
var player_state : PlayerStateComponent

var collider : CollisionShape3D

func _ready() -> void:
	register_player()
	register_components()

func register_player() -> void:
	PlayerManager.player = self

func register_components() -> void:
	health_component = $Components/HealthComponent
	stamina_component = $Components/StaminaComponent
	movement_controller = $Components/MovementController
	player_state = $Components/PlayerStateComponent
	collider = $Collider
	
