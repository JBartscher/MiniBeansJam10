extends NinePatchRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.drop_card.connect(_on_deselect)
	
	SignalBus.turn_progressed.connect(_on_turn_progressed)


# Calls all cards in PlayArea
func _on_turn_progressed() -> void:
	pass
	
	
func _on_deselect(card: Card, area: Area2D):
	if area not in $PlayDropZone/Area2D.get_overlapping_areas():
		return
		
	print("in play area")
	var pos = $PlayDropZone/Center.global_position 
	card.target_position = pos
	card.target_rotation = 0.0
		
	HandController.cards.erase(card)
	SignalBus.emit_signal("refresh_hand")
	SignalBus.emit_signal("action_progressed")
