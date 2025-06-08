extends NinePatchRect

var CARD_DUMMY = preload("res://Game/GameObjects/Card/card_dummy.tscn")
const CARD = preload("res://Game/GameObjects/Card/card.tscn")

# PLAY_AREA

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.drop_card.connect(_on_deselect)
	SignalBus.turn_progressed.connect(_on_turn_progressed)
	
	# recreate cards for still in play after shop.
	if len(DeckController.cards_in_play_buffer_between_scene_transitition) > 0:
		for c_r in DeckController.cards_in_play_buffer_between_scene_transitition:
			var card:Card = CARD.instantiate()
			card.card_resource = c_r.duplicate()
			HandController.add_card_to_hand(card)
			
			var pos = $PlayDropZone/Center.global_position 
			card.target_position = pos
			card.target_rotation = 0.0
			
			card.is_returning = false
			card.is_selected = false
			card.is_selectable = false
			
			card.position =  $PlayDropZone/Center.position
			card.position.y  += 40.0
			
			add_child(card)
			card.flip_card_to_front()
		DeckController.cards_in_play_buffer_between_scene_transitition = []


# Calls all cards in PlayArea
func _on_turn_progressed() -> void:
	for card: Card in DeckController.cards_in_play:
		card.effect.on_play(card.card_resource)
		card.effect.on_turn(card.card_resource)
		
		if card.effect.to_destroy(card.card_resource):
			print("destroy card ", card.card_resource.name)
			DeckController.cards_in_play.erase(card)
			card.queue_free()
			
		if card.effect.to_graveyard(card.card_resource):
			print("move card to graveyard", card.card_resource.name)
			var card_dummy:DummyCard = CARD_DUMMY.instantiate()
			card_dummy.global_position = $PlayDropZone/Center.global_position
			card_dummy.card_resource = card.card_resource.duplicate()
			SignalBus.emit_signal("add_card_to_graveyard", card_dummy)
			DeckController.cards_in_graveyard.append(card.card_resource.duplicate())
			card.queue_free()
			
	# todo doing that at the beginning might fix shop to graveyard?
	var cards_still_in_play = DeckController.cards_in_play.filter(func(c:Card): return not c.effect.to_graveyard(c.card_resource))
	
	if cards_still_in_play == null:
		cards_still_in_play = []
	DeckController.cards_in_play = cards_still_in_play
	
func _on_deselect(card: Card, area: Area2D):
	if not card.card_resource.can_be_played:
		return
	
	if area not in $PlayDropZone/Area2D.get_overlapping_areas():
		return
		
	$CardDropSfx.play()
	
	var pos = $PlayDropZone/Center.global_position 
	card.target_position = pos
	card.target_rotation = 0.0
	card.is_selectable = false
	
	DeckController.cards_in_play.append(card)	
	HandController.cards.erase(card)
	
	# call card on action method
	card.effect.on_action(card.card_resource)
	
	SignalBus.emit_signal("refresh_hand")
	SignalBus.emit_signal("action_progressed")
