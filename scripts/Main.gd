extends Node

@onready var _start_timer := $StartTimer
@onready var _start_position := $StartPosition
@onready var _player := $Player
@onready var _hud := $HUD
@onready var _background_music := $BackgroundMusic
@onready var _game_over_sound := $GameOverSound
@onready var _mob_spawner := $MobSpawner
@onready var _score_counter := $ScoreCounter

func _new_game():
	_score_counter.reset()
	_hud.show_temp_message("Get Ready!")
	
	_mob_spawner.remove_all_mobs()
	_player.start(_start_position.position)
	_start_timer.start()
	
	_background_music.play()

func _game_over():
	_score_counter.stop_counting()
	_mob_spawner.stop_spawn_mobs()
	_hud.show_game_over()
	_background_music.stop()
	_game_over_sound.play()

func _on_start_timer_timeout():
	_mob_spawner.start_spawn_mobs()
	_score_counter.start_counting()

func _on_score_counter_score_changed(score):
	_hud.update_score(score)
