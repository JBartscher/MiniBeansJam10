extends Node2D

func _ready() -> void:
	get_tree().set_current_scene(self)
	
	SignalBus.action_progressed.connect(_on_action_progressed)
	SignalBus.turn_progressed.connect(_on_turn_progressed)
	
	_on_balance_changed(GameState._account_balance)
	GameState.account_balance_changed.connect(_on_balance_changed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("quit"):
		get_tree().quit()
		
	if event.is_action_pressed("ui_down"):
		print(GameState.get_random_card_resource_from_pool())

func _on_balance_changed(new_balance: int):
	var money_label_fmt_str = "%s$"
	$CanvasLayer/VBoxContainer/Money.text = money_label_fmt_str % new_balance
	
func _on_action_progressed():
	var action_label_fmt_str = "Action: %s/3"
	$CanvasLayer/VBoxContainer/Action.text = action_label_fmt_str % GameState.action

func _on_turn_progressed():
	var turn_label_fmt_str = "Turn: %s"
	$CanvasLayer/VBoxContainer/Turn.text = turn_label_fmt_str % GameState.turn
