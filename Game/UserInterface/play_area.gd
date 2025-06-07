extends NinePatchRect

# PLAY_AREA

var cards_on_play = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.drop_card.connect(_on_deselect)
	
	SignalBus.turn_progressed.connect(_on_turn_progressed)


# Calls all cards in PlayArea
func _on_turn_progressed() -> void:
	for card: Card in cards_on_play:
		card.effect.on_buy()
	
	
func _on_deselect(card: Card, area: Area2D):
	if area not in $PlayDropZone/Area2D.get_overlapping_areas():
		return
		
	print("in play area")
	var pos = $PlayDropZone/Center.global_position 
	card.target_position = pos
	card.target_rotation = 0.0
	
	cards_on_play.append(card)	
	HandController.cards.erase(card)
	
	# call card on action method
	card.effect.on_action()
	
	SignalBus.emit_signal("refresh_hand")
	SignalBus.emit_signal("action_progressed")
