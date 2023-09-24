class_name HUD extends CanvasLayer

signal start_game

@onready var _score_label := $ScoreLabel
@onready var _message_label := $MessageLabel
@onready var _message_timer := $MessageTimer
@onready var _start_button := $StartButton

func show_message(message: String):
	_message_label.text = message
	_message_label.show()

func show_temp_message(message: String) -> Signal:
	show_message(message)
	_message_timer.start()
	return _message_timer.timeout

func show_game_over():
	await show_temp_message("Game Over")
	show_message("Dodge the Creeps!")
	
	await get_tree().create_timer(1.0).timeout
	_start_button.show()

func update_score(score):
	_score_label.text = str(score)

func _on_start_button_pressed():
	_start_button.hide()
	start_game.emit()

func _on_message_timer_timeout():
	_message_label.hide()
