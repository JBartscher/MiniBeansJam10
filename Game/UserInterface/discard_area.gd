extends NinePatchRect

# DISCARD_AREA
var cards_on_discard = []

var CARD_DUMMY = preload("res://Game/GameObjects/Card/card_dummy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.drop_card.connect(_on_deselect)
	SignalBus.turn_progressed.connect(_on_turn_progressed)

# Calls all cards in DiscardArea
func _on_turn_progressed() -> void:
	var cards_to_remove = []
	
	for card: Card in cards_on_discard:
		card.effect.on_discard()
		#if card.effect.to_destroy():
			#print("destroy card ", card.card_resource.name)
		if card.effect.to_graveyard():
			print("move card to graveyard ", card.card_resource.name)
			var card_dummy:DummyCard = CARD_DUMMY.instantiate()
			card_dummy.global_position = $DiscardDropZone/Center.global_position
			card_dummy.card_resource = card.card_resource.duplicate()
			SignalBus.emit_signal("add_card_to_graveyard", card_dummy)
			cards_to_remove.append(card)
			card.queue_free()
	cards_on_discard = []

	
func _on_deselect(card: Card, area: Area2D):
	if not card.card_resource.can_be_discarded:
		return
	
	if area not in $DiscardDropZone/Area2D.get_overlapping_areas():
		return
		
	print("in discard area")
	var pos = $DiscardDropZone/Center.global_position
	card.target_position = pos
	card.target_rotation = 0.0
	card.is_selected = false
	
	cards_on_discard.append(card)
	HandController.cards.erase(card)
	
	# call card on action method
	card.effect.on_action()
	
	SignalBus.emit_signal("refresh_hand")
	SignalBus.emit_signal("action_progressed")
	
