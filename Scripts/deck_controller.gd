extends Node

var cards_in_deck = []

func get_top_card():
	if cards_in_deck.is_empty():
		return
	
	return cards_in_deck.pop_front() 
	
func add_card_to_deck(card: PlayingCard):
	cards_in_deck.append(card)
	print("cards in deck: ", len(cards_in_deck))
	
func return_card_to_deck(card: PlayingCard):
	cards_in_deck.append(card)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards_in_deck.append(GameState.big_loan_resource)
	cards_in_deck.append(GameState.small_loan_resource)
	cards_in_deck.append(GameState.big_loan_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.shopping_resource)
