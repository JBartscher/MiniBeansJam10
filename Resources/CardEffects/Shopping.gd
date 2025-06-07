extends CardEffect

var SHOP_SCENE:PackedScene = preload("res://Game/Scenes/shop.tscn")

func on_sell():
	print("shopping on action")
	
func on_action():
	print("shopping on action")

func on_buy():
	print("go to shop")
	SignalBus.emit_signal("change_scene", SHOP_SCENE)

func on_turn():
	print("shopping on turn")
	
