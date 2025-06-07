extends NinePatchRect

# DISCARD_AREA
var cards_on_discard = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.drop_card.connect(_on_deselect)
	SignalBus.turn_progressed.connect(_on_turn_progressed)

# Calls all cards in DiscardArea
func _on_turn_progressed() -> void:
	for card: Card in cards_on_discard:
		card.effect.on_buy()
	# todo return to deck or graveyard

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_deselect(card: Card, area: Area2D):
	if area not in $DiscardDropZone/Area2D.get_overlapping_areas():
		return
		
	print("in discard area")
	var pos = $DiscardDropZone/Center.global_position 
	card.target_position = pos
	card.target_rotation = 0.0
	
	cards_on_discard.append(card)
	HandController.cards.erase(card)
	
	# call card on action method
	card.effect.on_action()
	
	SignalBus.emit_signal("refresh_hand")
	SignalBus.emit_signal("action_progressed")
	
