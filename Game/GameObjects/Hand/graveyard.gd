extends Control

@export var CardOffset: float = 0.8



var DUMMY_CARD = preload("res://Game/GameObjects/Card/card_dummy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var i = 0
	for card_in_graveyard in DeckController.cards_in_graveyard:
		var dummy_card = DUMMY_CARD.instantiate()
		dummy_card.position.x += CardOffset * i
		dummy_card.position.y += -1 * CardOffset * i
		i += 1
		add_child(dummy_card)
		
	SignalBus.connect("graveyard_cards_to_deck", _on_graveyard_cards_to_deck)
	
func _on_graveyard_cards_to_deck():
	for c in get_children():
		pass
