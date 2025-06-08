extends CardEffect

var SHOP_SCENE:PackedScene = preload("res://Game/Scenes/shop.tscn")
	
func on_action(resource: PlayingCard):
	SignalBus.emit_signal("draw_to_hand")
	SignalBus.emit_signal("draw_to_hand")
	
func to_graveyard(resource: PlayingCard) -> bool:
	return true

func to_destroy(resource: PlayingCard) -> bool:
	return false
