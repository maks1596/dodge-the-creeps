class_name MobSpawner extends Node

const _MIN_SPEED = 150.0
const _MAX_SPEED = 250.0

@export var mob_scenes: Array[PackedScene]
@export var mob_parent_node: Node
@export var spawn_period := 0.75:
	set(value):
		spawn_period = value
		if _spawn_mob_timer: _spawn_mob_timer.wait_time = value

@onready var _spawn_mob_timer := $SpawnMobTimer
@onready var _mob_spawn_location := $MobPath/MobSpawnLocation

func _ready():
	if not mob_parent_node: mob_parent_node = get_parent()
	spawn_period = spawn_period

func start_spawn_mobs():
	_spawn_mob_timer.start()

func stop_spawn_mobs():
	_spawn_mob_timer.stop()

func remove_all_mobs():
	get_tree().call_group("Mobs", "queue_free")

func _spawn_mob():
	var mob := _instantiate_random_mob()
	_setup_mob(mob)
	mob_parent_node.add_child(mob)
	
func _instantiate_random_mob() -> Node:
	var mob_index = randi() % mob_scenes.size()
	var mob_scene = mob_scenes[mob_index]
	return mob_scene.instantiate()

func _setup_mob(mob: Node):
	var mob_spawn_location = _random_location()
	mob.position = mob_spawn_location.position
	mob.rotation = _random_rotation(mob_spawn_location)
	mob.linear_velocity = _random_velocity(mob.rotation)

func _random_location():
	var spawn_location = _mob_spawn_location
	spawn_location.progress_ratio = randf()
	return spawn_location

func _random_rotation(location):
	return location.rotation + randf_range(PI * 0.25, PI * 0.75)

func _random_velocity(mob_rotation): 
	var speed := randf_range(_MIN_SPEED, _MAX_SPEED)
	return Vector2(speed, 0.0).rotated(mob_rotation)
