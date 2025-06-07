extends Control

const SHOPPING_ITEM = preload("res://Game/UserInterface/shopping_item.tscn")

const GAME_SCENE = preload("res://Game/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	_on_balance_changed(GameState._account_balance)
	GameState.account_balance_changed.connect(_on_balance_changed)
	
	for i in 3:
		var card_resource = GameState.get_random_card_resource_from_pool()
		var shopping_item = SHOPPING_ITEM.instantiate()
		shopping_item.init(card_resource)
		$MarginContainer/Items.add_child(shopping_item)
		
func _on_balance_changed(new_balance: int):
	var money_label_fmt_str = "%s$"
	$MarginContainer/Money.text = money_label_fmt_str % new_balance


func _on_continue_button_pressed() -> void:
	SignalBus.emit_signal("change_scene", GAME_SCENE)
