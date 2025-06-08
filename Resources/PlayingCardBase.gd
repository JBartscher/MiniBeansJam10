class_name PlayingCard
extends Resource

@export var cost: int = 0
@export var texture: Texture2D
@export var name: String
@export var description: String
@export var card_effect: GDScript
@export var can_be_played: bool = true
@export var can_be_discarded: bool = true
@export var active_for_n_turns: int = 0
