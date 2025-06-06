extends NinePatchRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.drop_card.connect(_on_deselect)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_deselect(card: Card, area: Area2D):
	if area in $DiscardDropZone/Area2D.get_overlapping_areas():
		print("in discard area")
		var pos = $DiscardDropZone/Center.global_position 
		card.target_position = pos
		card.target_rotation = 0.0
		
	HandController.cards.erase(card)
	SignalBus.emit_signal("refresh_hand")
	
