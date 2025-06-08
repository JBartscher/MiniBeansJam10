extends CardEffect

var SHOP_SCENE:PackedScene = preload("res://Game/Scenes/shop.tscn")
	
func on_play():
	print("go to shop")
	if len(HandController.cards) > 0:
		print("still cards in hand, save to next hand")
		for c:Card in HandController.cards:
			HandController.card_buffer_between_scene_transitition.append(c.card_resource)
		HandController.cards = []
		
	SignalBus.emit_signal("change_scene", SHOP_SCENE)
