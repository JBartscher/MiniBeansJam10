extends Node

signal changed_stage(stage: int)

signal action_progressed
signal turn_progressed

signal refresh_hand

signal drop_card(card: Card, card_area: Area2D)

func _ready() -> void:
	pass # Replace with function body.
