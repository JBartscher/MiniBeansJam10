extends Control

@export var CardOffset: float = 0.8

var DUMMY_CARD = preload("res://Game/GameObjects/Card/card_dummy.tscn")

var tween_move_to_graveyard: Tween

func _ready() -> void:
	var i = 0
	for card_in_graveyard in DeckController.cards_in_graveyard:
		var dummy_card: DummyCard = DUMMY_CARD.instantiate()
		dummy_card.card_resource = card_in_graveyard
		dummy_card.position.x += CardOffset * i
		dummy_card.position.y += -1 * CardOffset * i
		i += 1
		add_child(dummy_card)
		
	SignalBus.connect("graveyard_cards_to_deck", _on_graveyard_cards_to_deck)
	SignalBus.connect("add_card_to_graveyard", _on_add_card_to_graveyard)
	
func _on_graveyard_cards_to_deck():
	for c in get_children():
		pass

func _on_add_card_to_graveyard(dummy_card: DummyCard):
	if not is_inside_tree():
		# scene change happend we dont need to animate anything
		return
		
	tween_move_to_graveyard = get_tree().create_tween()
	var final_position = self.global_position
	final_position.x += CardOffset * len(DeckController.cards_in_graveyard)
	final_position.y += -1 * CardOffset * len(DeckController.cards_in_graveyard)
	
	# needed as we set the pos beforehand and that would be out of the screen
	dummy_card.global_position -= final_position
	
	tween_move_to_graveyard.set_ease(Tween.EASE_IN_OUT)
	tween_move_to_graveyard.set_trans(Tween.TRANS_EXPO)
	tween_move_to_graveyard.tween_property(dummy_card, "global_position", final_position, 0.5)
	self.add_child(dummy_card)
