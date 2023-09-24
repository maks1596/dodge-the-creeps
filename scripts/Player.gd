class_name Player extends Area2D

signal hit

@export var speed = 400

@onready var _screen_size := get_viewport_rect().size
@onready var _animated_sprite := $AnimatedSprite2D
@onready var _collision_shape := $CollisionShape2D

func start(start_position):
	position = start_position
	show()
	_collision_shape.disabled = false

func _ready():
	hide()

func _process(delta):
	var direction := _get_input_direction()
	var is_moving := direction.length() > 0
	
	if is_moving:
		_move(direction, delta)
		_play_move_animation(direction)
	else:
		_stop_move_animation()

func _get_input_direction() -> Vector2:
	var direction = Vector2.ZERO
	if (Input.is_action_pressed("move_right")):
		direction.x = 1
	if (Input.is_action_pressed("move_left")):
		direction.x = -1
	if (Input.is_action_pressed("move_up")):
		direction.y = -1
	if (Input.is_action_pressed("move_down")):
		direction.y = 1
	return direction

func _move(direction: Vector2, delta: float):
	var velocity = direction.normalized() * speed
	var new_position = position + velocity * delta
	position = new_position.clamp(Vector2.ZERO, _screen_size)
	
func _play_move_animation(direction: Vector2):
	_animated_sprite.animation = _direction_to_animation(direction)
	_animated_sprite.flip_v = direction.y > 0
	_animated_sprite.flip_h = direction.x < 0
	
	if not _animated_sprite.is_playing():
		_animated_sprite.play()

func _stop_move_animation():
	if _animated_sprite.is_playing():
		_animated_sprite.stop()

func _direction_to_animation(direction: Vector2):
	if direction.x != 0:
		return "walk"
	if direction.y != 0:
		return "up"

func _on_body_entered(_body):
	_collision_shape.set_deferred("disabled", true)
	hide()
	hit.emit()
