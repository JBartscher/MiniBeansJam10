extends Control

const SHOPPING_ITEM = preload("res://Game/UserInterface/shopping_item.tscn")

const GAME_SCENE = preload("res://Game/game.tscn")

func _ready() -> void:
	# dont know why this buggs
	HandController.cards = []
	
	_on_balance_changed(GameState._account_balance, GameState._account_balance)
	GameState.account_balance_changed.connect(_on_balance_changed)
	
	for i in 3:
		var card_resource = GameState.get_random_card_resource_from_pool()
		var shopping_item = SHOPPING_ITEM.instantiate()
		shopping_item.init(card_resource)
		$MarginContainer/Items.add_child(shopping_item)
		

func _on_balance_changed(old_balance: int, new_balance: int):
	animate_balance_value_change(old_balance, new_balance)
	
func animate_balance_value_change(value_before: int, new_value:int):
	#$UI/CoinCounter/Coin/CopperCoinParticle.emitting = true
	#$UI/CoinCounter/Coin/SilverCoinParticle.emitting = true
	#$UI/CoinCounter/Coin/GoldCoinParticle.emitting = true
	
	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.tween_method(count_to, value_before, new_value, 1.2)

func count_to(value:int) -> void:
	var money_label_fmt_str = "%s$"
	$MarginContainer/Money.text = money_label_fmt_str % value

func _on_continue_button_pressed() -> void:
	$ButtonClickSfx.connect("finished", func(): return SignalBus.emit_signal("change_scene", GAME_SCENE))
	$ButtonClickSfx.play()


func _on_continue_button_mouse_entered() -> void:
	$ButtonHoverSfx.play()
