class_name ActiveCharacter extends CharacterBody2D

@export var activeChar : bool = true
@export var upCharacter : bool = true
var signAct : float = -1.0
var actionJump : String = "move_up"

func _ready() -> void:
	if !upCharacter:
		signAct = 1.0
		actionJump = "move_down"
		
func kill() -> void:
	activeChar = false
	visible = false

func jump() -> void:
	velocity.y = Global.jump_speed * signAct
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	visible = activeChar
	if not is_on_floor():
		velocity -= Global.gravity_val * delta * signAct

	# Handle jump.
	if activeChar:
		if Input.is_action_just_pressed(actionJump) and is_on_floor():
			jump()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * Global.move_speed
	else:
		velocity.x = move_toward(velocity.x, 0, Global.move_speed)

	move_and_slide()
