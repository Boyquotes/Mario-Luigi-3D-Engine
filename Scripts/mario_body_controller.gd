extends CharacterBody3D

# child nodes #
@onready var anim_sprite = $MarioSprite
@onready var head_collision_shape = $MarioHead
@onready var feet_collision_shape = $MarioFeet

# physic vars #
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
const MOVE_SPEED = 5.25
const JUMP_VELOCITY = 4.0

var direction = Vector3.ZERO

enum anim_types {Idle, Walk, Jump}

enum State {FLOOR, AIR}
var state = State.AIR

func play_directional_anim(type):
	match type:
		anim_types.Idle:
			if direction.x == 0:
				if direction.z < -0.2: anim_sprite.play("Idle Up")
				elif direction.z > 0.2: anim_sprite.play("Idle Down")
			if direction.z == 0:
				if direction.x > 0.2: anim_sprite.play("Idle Right")
				elif direction.x < -0.2: anim_sprite.play("Idle Left")
				
			if direction.z > 0.2 and direction.x < -0.2: anim_sprite.play("Idle Down_Left")
			elif direction.z > 0.2 and direction.x > 0.2: anim_sprite.play("Idle Down_Right")
			
			if direction.z < -0.2 and direction.x < -0.2: anim_sprite.play("Idle Up_Left")
			elif direction.z < -0.2 and direction.x > 0.2: anim_sprite.play("Idle Up_Right")

func check_state():
	if is_on_floor(): state = State.FLOOR
	elif not is_on_floor(): state = State.AIR

func _input(_event):
	direction.x = clamp(Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left"), -1, 1)
	direction.z = clamp(Input.get_action_strength("Move_Backwards") - Input.get_action_strength("Move_Forward"), -1, 1)

func _physics_process(delta):
	match state:
		State.AIR:
			check_state()

			velocity.x = direction.x * MOVE_SPEED
			velocity.z = direction.z * MOVE_SPEED
			velocity.y -= gravity * delta

			play_directional_anim(anim_types.Idle)

		State.FLOOR:
			check_state()

			velocity.x = direction.x * MOVE_SPEED
			velocity.z = direction.z * MOVE_SPEED
			
			if is_on_floor() and Input.is_action_just_pressed("Move_Jump"):
				velocity.y += JUMP_VELOCITY
				check_state()

			play_directional_anim(anim_types.Idle)
	
	move_and_slide()
	print_debug(direction)
