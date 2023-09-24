class_name Mob extends RigidBody2D

@onready var _animated_sprite := $AnimatedSprite2D

func _ready():
	_play_random_animation()

func _play_random_animation():
	var frames = _animated_sprite.sprite_frames
	var animation_names = frames.get_animation_names()
	var animation_index = randi() % animation_names.size()
	var animation_name = animation_names[animation_index]
	_animated_sprite.play(animation_name)

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
