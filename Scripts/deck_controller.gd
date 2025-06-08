extends Node

var cards_in_graveyard = []
var cards_in_deck = []

var cards_in_play = []
var cards_in_play_buffer_between_scene_transitition = []

func get_top_card_of_deck():
	print("cards in deck: ",len(cards_in_deck))
	print("cards in graveyard: ",len(cards_in_graveyard))
	
	if cards_in_deck.is_empty():
		cards_in_deck = cards_in_graveyard.duplicate(true)
		cards_in_graveyard = []
		cards_in_deck.shuffle()
		SignalBus.emit_signal("graveyard_cards_to_deck")
	
	var card = cards_in_deck.pop_front() 
	SignalBus.emit_signal("draw_card_from_deck")
	return card
	
func add_card_to_deck(card: PlayingCard):
	cards_in_deck.append(card)
	print("cards in deck: ", len(cards_in_deck))
	SignalBus.emit_signal("put_card_in_deck")
	
	
func init():
	cards_in_play = []
	cards_in_play_buffer_between_scene_transitition = []
	
	cards_in_graveyard = []
	cards_in_graveyard.append(GameState.bad_investment_resource)
	cards_in_graveyard.append(GameState.bad_investment_resource)
	
	cards_in_deck = []
	cards_in_deck.append(GameState.wage_work_resource)
	cards_in_deck.append(GameState.small_loan_resource)
	cards_in_deck.append(GameState.shopping_resource)
	cards_in_deck.append(GameState.corporate_greed_resource)

func _ready() -> void:
	init()
