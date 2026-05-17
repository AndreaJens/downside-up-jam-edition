extends Node2D

@export var timer : Timer
@export var parentEn : Node
@export var period : float = 5.0
@export var timerPeriod : float = 1.0
var enemyProtoUp : PackedScene = load("res://enemy.tscn")
var timeAcc : float

signal player_hit(damage : int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start()
	pass # Replace with function body.

func shoot_enemy() -> void:
	var newEnemy = enemyProtoUp.instantiate()
	newEnemy.global_position = global_position
	newEnemy.flight_speed *= Global.rng.randf_range(0.9, 1.5)
	if newEnemy.global_position.y <= 270:
		newEnemy.global_position.y = min(newEnemy.global_position.y, 250)
	elif newEnemy.global_position.y > 270:
		newEnemy.global_position.y = max(newEnemy.global_position.y, 290)
	newEnemy.player_hit.connect(_on_enemy_collision)
	newEnemy.despawn_alert.connect(_on_enemy_despawn)
	parentEn.add_child(newEnemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timeAcc += delta
	position.y = 270 + 120 * cos(2 * PI * timeAcc / period)

func _on_timer_timeout() -> void:
	shoot_enemy()
	timer.wait_time = Global.rng.randf_range(0.6, 1.0) * timerPeriod

func _on_enemy_collision(damage : int) -> void:
	player_hit.emit(damage)
	print("OK")

func _on_enemy_despawn(enemy : Enemy) -> void:
	enemy.player_hit.disconnect(_on_enemy_collision)
	enemy.despawn_alert.disconnect(_on_enemy_despawn)
	enemy.queue_free()
	print("DESPAWN")
