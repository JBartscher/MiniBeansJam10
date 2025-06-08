extends CardEffect

var bad_investement = preload("res://Resources/CardResources/bad_investment.tres")

var found = false

func on_play(resource: PlayingCard):
	print("personal bankruptcy on play")
	if DeckController.cards_in_deck.has(bad_investement):
		print("remove bad investment from deck")
		DeckController.cards_in_deck.erase(bad_investement)
		found = true
	
	if not found && DeckController.cards_in_graveyard.has(bad_investement):
		print("remove bad investment from graveyard")
		DeckController.cards_in_graveyard.erase(bad_investement)
	
func to_destroy(resource: PlayingCard) -> bool:
	return true
	
func to_graveyard(resource: PlayingCard) -> bool:
	return true
