class_name Enemy extends Node2D

@export var flight_speed : float = 200
@export var damage : int = 1
@export var textureUp : Texture2D
@export var textureDown : Texture2D
@onready var sprite : Sprite2D = $Sprite2D

signal player_hit(damage : int)
signal despawn_alert(entity : Enemy)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if global_position.y <= 270:
		sprite.texture = textureUp
	else:
		sprite.texture = textureDown
	position.x -= flight_speed * delta
	if global_position.x < -96:
		despawn()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.visible:
		print("collision")
		player_hit.emit(damage)

func despawn() -> void:
	despawn_alert.emit(self)
	
