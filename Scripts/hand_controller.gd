extends Node

var card_buffer_between_scene_transitition = []
var cards = []

func get_card(index: int):
	return cards[index]

func add_card_to_hand(card: Card):
	cards.append(card)

func index_of(card: Card):
	return cards.find(card)

func remove_card_from_hand(card: Card):
	cards.erase(card)
