extends Node

var _account_balance: int = 10

var action = 0
var max_actions = 3

var turn = 0

signal account_balance_changed(account_balance: int)

func change_account_balance(amount: int):
	_account_balance += amount
	emit_signal("account_balance_changed", _account_balance)

func _ready() -> void:
	SignalBus.action_progressed.connect(_on_action_progressed)
	SignalBus.turn_progressed.connect(_on_turn_progressed)
	
func _on_action_progressed():
	print("action ", action)
	action += 1
	if action == max_actions:
		action = 0
		SignalBus.turn_progressed.emit()

func _on_turn_progressed():
	turn += 1
	print("progress turn to ", turn)
