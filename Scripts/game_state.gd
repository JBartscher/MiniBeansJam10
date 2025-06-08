extends Node

var first_round = true
var _account_balance: int = 10

var action = 0
var max_actions = 3

var turn = 0

var small_loan_resource = preload("res://Resources/CardResources/small_loan.tres")
var big_loan_resource = preload("res://Resources/CardResources/big_loan.tres")
var shopping_resource = preload("res://Resources/CardResources/shopping.tres")
var bad_investment_resource = preload("res://Resources/CardResources/bad_investment.tres")
var personal_bankruptcy_resource = preload("res://Resources/CardResources/personal_bankruptcy.tres")
var corporate_greed_resource = preload("res://Resources/CardResources/corporate_greed.tres")
var crypto_scam_resource = preload("res://Resources/CardResources/crypto_scam.tres")
var wage_work_resource = preload("res://Resources/CardResources/wage_work.tres")

var card_pool = []

signal account_balance_changed(old_account_balance: int, new_account_balance: int)

func _on_change_scene(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)

func get_random_card_resource_from_pool() -> PlayingCard:
	var random_card_resource = card_pool.pick_random()
	return random_card_resource

func change_account_balance(amount: int):
	var old_balance = _account_balance
	var new_balance = _account_balance + amount
	emit_signal("account_balance_changed", old_balance, new_balance)
	_account_balance = new_balance 

func _ready() -> void:
	SignalBus.action_progressed.connect(_on_action_progressed)
	SignalBus.turn_progressed.connect(_on_turn_progressed)
	
	SignalBus.change_scene.connect(_on_change_scene)
	
	card_pool.append(small_loan_resource)
	card_pool.append(big_loan_resource)
	card_pool.append(shopping_resource)
	card_pool.append(bad_investment_resource)
	card_pool.append(personal_bankruptcy_resource)
	card_pool.append(corporate_greed_resource)
	card_pool.append(crypto_scam_resource)
	card_pool.append(wage_work_resource)
	
func _on_action_progressed():
	action += 1
	print("progress action to ", action)
	if action == max_actions:
		action = 0
		SignalBus.turn_progressed.emit()

func _on_turn_progressed():
	first_round = false
	turn += 1
	print("progress turn to ", turn)
	if _account_balance <= -25:
		get_tree().change_scene_to_file("res://Game/UserInterface/game_over.tscn")
