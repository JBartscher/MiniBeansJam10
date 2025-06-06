extends Node2D


var action = 0
var max_actions = 3

var turn = 0

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
	print("action ", action)
	action += 1
	if action == max_actions:
		action = 0
		SignalBus.turn_progressed.emit()

func _on_turn_progressed():
	stage += 1
	turn += 1
	print("stage ", stage)
	SignalBus.changed_stage.emit(stage)
	
	if stage == 10:
		print("game over")
	
	
