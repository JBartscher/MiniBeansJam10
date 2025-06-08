extends CardEffect

var SHOP_SCENE:PackedScene = preload("res://Game/Scenes/shop.tscn")
func on_play(resource: PlayingCard):
	print("go to shop")
	if len(HandController.cards) > 0:
		print("still cards in hand, save to next hand")
		HandController.cards = HandController.cards.filter(func(c:Card): return not null)
		
		# save active cards
		for c:Card in DeckController.cards_in_play:
			if c.card_resource.active_for_n_turns > 0:
				DeckController.cards_in_play_buffer_between_scene_transitition.append(c.card_resource.duplicate())
			else:
				DeckController.cards_in_graveyard.append(c.card_resource.duplicate())
				
		DeckController.cards_in_play = []
		
		# save cards in hand
		for c:Card in HandController.cards:
			HandController.card_buffer_between_scene_transitition.append(c.card_resource)
		HandController.cards = []
		
	SignalBus.emit_signal("change_scene", SHOP_SCENE)
