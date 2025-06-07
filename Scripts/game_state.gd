extends Node

var _account_balance: int = 10

var action = 0
var max_actions = 3

var turn = 0

var small_loan_resource = preload("res://Resources/CardResources/small_loan.tres")
var big_loan_resource = preload("res://Resources/CardResources/big_loan.tres")
var shopping_resource = preload("res://Resources/CardResources/shopping.tres")

var card_pool = []

signal account_balance_changed(account_balance: int)

func change_account_balance(amount: int):
	_account_balance += amount
	emit_signal("account_balance_changed", _account_balance)
	print("new balance: ", _account_balance)

func _ready() -> void:
	SignalBus.action_progressed.connect(_on_action_progressed)
	SignalBus.turn_progressed.connect(_on_turn_progressed)
	
	card_pool.append(small_loan_resource)
	card_pool.append(big_loan_resource)
	card_pool.append(shopping_resource)
	
func _on_action_progressed():
	action += 1
	print("progress action to ", action)
	if action == max_actions:
		action = 0
		SignalBus.turn_progressed.emit()

func _on_turn_progressed():
	turn += 1
	print("progress turn to ", turn)
