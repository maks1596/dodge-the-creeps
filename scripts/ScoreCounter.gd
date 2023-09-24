class_name ScoreCounter extends Node

signal score_changed(score: int)

@onready var _timer := $Timer

var _score_value := 0:
	set(value):
		_score_value = value
		score_changed.emit(value)

func reset():
	_score_value = 0

func start_counting():
	_timer.start()

func stop_counting():
	_timer.stop()

func _on_timer_timeout():
	_score_value += 1
