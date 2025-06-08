extends CardEffect

var bad_investement = preload("res://Resources/CardResources/bad_investment.tres")

var found = false

func on_play():
	print("personal bankruptcy on buy")
	if DeckController.cards_in_deck.has(bad_investement):
		print("remove bad investment from deck")
		DeckController.cards_in_deck.erase(bad_investement)
		found = true
	
	if not found && DeckController.cards_in_graveyard.has(bad_investement):
		DeckController.cards_in_graveyard.erase(bad_investement)
		
	while true:
		print(len(DeckController.cards_in_deck))
		var search_result = DeckController.cards_in_deck.has(bad_investement)
		if not search_result:
			break
		else:
			print("remove bad investment from deck")
			DeckController.cards_in_deck.erase(bad_investement)
			print(len(DeckController.cards_in_deck))
	
func to_destroy() -> bool:
	return true
	
func to_graveyard() -> bool:
	return true
