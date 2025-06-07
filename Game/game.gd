extends Node2D

var stage = 0

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
		
	if event.is_action_pressed("ui_down"):
		SignalBus.action_progressed.emit()
		
	
	
