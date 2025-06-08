extends Node

signal action_progressed
signal turn_progressed

signal refresh_hand

signal drop_card(card: Card, card_area: Area2D)

signal change_scene(scene: PackedScene)

signal add_card_to_graveyard(card: DummyCard)
signal graveyard_cards_to_deck
signal draw_card_from_deck
signal put_card_in_deck
