extends Node

var cards = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func get_card(index: int):
	return cards[index]

func add_card_to_hand(card: Card):
	cards.append(card)

func index_of(card: Card):
	return cards.find(card)

func remove_card_from_hand(card: Card):
	cards.erase(card)
