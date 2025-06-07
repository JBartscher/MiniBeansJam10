extends Node2D

var stage = 0

func _ready() -> void:
	SignalBus.action_progressed.connect(_on_action_progressed)
	SignalBus.turn_progressed.connect(_on_turn_progressed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
		
	if event.is_action_pressed("ui_down"):
		SignalBus.action_progressed.emit()
		

func _on_action_progressed():
	print("reeee")
	var action_label_fmt_str = "Action: %s/3"
	$CanvasLayer/VBoxContainer/Action.text = action_label_fmt_str % GameState.action

func _on_turn_progressed():
	var turn_label_fmt_str = "Turn: %s"
	$CanvasLayer/VBoxContainer/Turn.text = turn_label_fmt_str % GameState.turn
