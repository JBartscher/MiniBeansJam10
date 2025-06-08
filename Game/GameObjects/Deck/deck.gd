extends Control

@export var CardOffset: float = 0.8

var card_back_texture = preload("res://Assets/Cards/PlayCardLayoutBack.png")

func _ready() -> void:
	for i in len(DeckController.cards_in_deck):
		var s = Sprite2D.new()
		s.texture = card_back_texture
		s.position.x += CardOffset * i
		s.position.y += -1 * CardOffset * i
		add_child(s)
		
	SignalBus.connect("draw_card_from_deck", _on_draw_card_from_deck)
	SignalBus.connect("put_card_in_deck", _on_put_card_in_deck)
	SignalBus.connect("graveyard_cards_to_deck", _on_graveyard_cards_to_deck)

func _on_draw_card_from_deck():
	get_children().back().queue_free()

func _on_put_card_in_deck():
		var i = len(DeckController.cards_in_deck)
		var s = Sprite2D.new()
		s.texture = card_back_texture
		s.position.x += CardOffset * i
		s.position.y += -1 * CardOffset * i
		add_child(s)
	
func _on_graveyard_cards_to_deck():
	for c in get_children():
		c.queue_free()
	
	for i in len(DeckController.cards_in_deck):
		var s = Sprite2D.new()
		s.texture = card_back_texture
		s.position.x += CardOffset * i
		s.position.y += -1 * CardOffset * i
		add_child(s)
