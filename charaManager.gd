extends Node

@export var playerUp : CharacterBody2D
@export var playerDown : ActiveCharacter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerDown.activeChar = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if playerUp.activeChar and playerUp.is_on_floor():
		if Input.is_action_just_pressed("move_down"):
			playerUp.activeChar = false
			playerDown.activeChar = true
			playerDown.jump()
			#playerUp.velocity = Vector2(0,0)
	elif playerDown.activeChar and playerDown.is_on_floor():
		if Input.is_action_just_pressed("move_up"):
			playerUp.activeChar = true
			playerDown.activeChar = false
			playerUp.jump()
			#playerDown.velocity = Vector2(0,0)
