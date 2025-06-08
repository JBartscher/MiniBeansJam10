extends CardEffect

var SHOP_SCENE:PackedScene = preload("res://Game/Scenes/shop.tscn")
	
func on_action():
	SignalBus.emit_signal("draw_to_hand")
	SignalBus.emit_signal("draw_to_hand")
