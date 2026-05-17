extends CharacterBody2D

@export var activeChar : bool = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += Global.gravity_val * delta

	# Handle jump.
	if Input.is_action_just_pressed("move_up") and is_on_floor():
		velocity.y = -Global.jump_speed

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * Global.move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, Global.move_speed)

	move_and_slide()
