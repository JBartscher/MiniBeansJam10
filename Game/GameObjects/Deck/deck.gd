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
		
