extends Control


func _ready() -> void:
	GameState._account_balance = 10
	GameState.turn = 0
	GameState.action = 0
	
	HandController.cards = []
	HandController.card_buffer_between_scene_transitition = []
	
	DeckController.init()
	

func _on_start_button_pressed() -> void:
	$ButtonClickSfx.play()
	$ButtonClickSfx.connect("finished", func(): return get_tree().change_scene_to_file("res://Game/game.tscn"))

func _on_start_button_mouse_entered() -> void:
	$ButtonHoverSfx.play()
	
