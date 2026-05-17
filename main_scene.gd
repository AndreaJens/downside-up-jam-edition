extends Node2D

@export var lifebar : TextureProgressBar
signal gameover()
var score : float = 0
@export var scoreLabel : Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	lifebar.value = 3
	scoreLabel.text = "0"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lifebar.value > 0:
		score += delta * 5
		scoreLabel.text = str(int(score))
	else:
		if Input.is_action_just_pressed("restart"):
			get_tree().reload_current_scene()

func _on_player_damage(damage : int) -> void:
	lifebar.value -= damage
	if lifebar.value <= 0:
		gameover.emit()
