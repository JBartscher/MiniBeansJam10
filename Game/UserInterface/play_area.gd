extends NinePatchRect

var CARD_DUMMY = preload("res://Game/GameObjects/Card/card_dummy.tscn")

# PLAY_AREA
var cards_on_play = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.drop_card.connect(_on_deselect)
	SignalBus.turn_progressed.connect(_on_turn_progressed)


# Calls all cards in PlayArea
func _on_turn_progressed() -> void:
	for card: Card in cards_on_play:
		card.effect.on_play()
		
		if card.effect.to_destroy():
			print("destroy card ", card.card_resource.name)
			cards_on_play.erase(card)
			card.queue_free()
			
		if card.effect.to_graveyard():
			print("move card to graveyard", card.card_resource.name)
			var card_dummy:DummyCard = CARD_DUMMY.instantiate()
			card_dummy.global_position = $PlayDropZone/Center.global_position
			card_dummy.card_resource = card.card_resource.duplicate()
			SignalBus.emit_signal("add_card_to_graveyard", card_dummy)
			DeckController.cards_in_graveyard.append(card.card_resource.duplicate())
			card.queue_free()
	
	var cards_still_in_play = cards_on_play.filter(func(c:Card): return not c.effect.to_graveyard())
	cards_on_play = cards_still_in_play
	
func _on_deselect(card: Card, area: Area2D):
	if not card.card_resource.can_be_played:
		return
	
	if area not in $PlayDropZone/Area2D.get_overlapping_areas():
		return
		
	$CardDropSfx.play()
	
	var pos = $PlayDropZone/Center.global_position 
	card.target_position = pos
	card.target_rotation = 0.0
	
	cards_on_play.append(card)	
	HandController.cards.erase(card)
	
	# call card on action method
	card.effect.on_action()
	
	SignalBus.emit_signal("refresh_hand")
	SignalBus.emit_signal("action_progressed")
