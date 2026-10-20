extends CharacterBody2D

const COYOTE_TIME: float = 0.5
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

var animation: String = &"Idle"
var prev_animation: String = &"Idle"

var airtime: int = 0

func _ready() -> void:
	$AnimatedSprite.play(animation)

# Animation
func _process(delta: float) -> void:
	pass

# Physics
func _physics_process(delta: float) -> void:
	self.falling(delta)
	self.jumping()
	self.movement()
	move_and_slide()

func jumping() -> void:
	var on_floor = is_on_floor() or (airtime < COYOTE_TIME)
	if Input.is_action_just_pressed("ui_select") and (on_floor):
		self.velocity.y = JUMP_VELOCITY

	if on_floor:
		self.velocity.y = 0

func falling(delta: float):
	if not is_on_floor():
		velocity += get_gravity() * delta

func movement():
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
