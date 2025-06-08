extends Node

var cards_in_graveyard = []

var cards_in_deck = []

func get_top_card():
	if cards_in_deck.is_empty():
		cards_in_deck = cards_in_graveyard.duplicate(true)
		cards_in_deck.shuffle()
		SignalBus.emit_signal("graveyard_cards_to_deck")
	
	SignalBus.emit_signal("draw_card_from_deck")
	return cards_in_deck.pop_front() 
	
func add_card_to_deck(card: PlayingCard):
	cards_in_deck.append(card)
	print("cards in deck: ", len(cards_in_deck))
	SignalBus.emit_signal("put_card_in_deck")
	
func return_card_to_deck(card: PlayingCard):
	cards_in_deck.append(card)
	SignalBus.emit_signal("put_card_in_deck")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards_in_graveyard.append(GameState.bad_investment_resource)
	
	cards_in_deck.append(GameState.big_loan_resource)
	cards_in_deck.append(GameState.small_loan_resource)
	cards_in_deck.append(GameState.big_loan_resource)
	cards_in_deck.append(GameState.personal_bankruptcy_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.bad_investment_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.bad_investment_resource)
	cards_in_deck.append(GameState.bad_investment_resource)
	cards_in_deck.append(GameState.bad_investment_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.shopping_resource)
