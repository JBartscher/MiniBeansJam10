extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var points_label_str_fmt =  "[wave amp=100.0, freq=2,5., connected=1]You made it to turn %s[/wave]"
	$MarginContainer/VBoxContainer/Points.text = points_label_str_fmt % GameState.turn
	
	# change scene after sound
	$ButtonClickSfx.connect("finished", func(): return get_tree().change_scene_to_file("res://Game/UserInterface/main_menu.tscn"))
func _on_to_menu_button_pressed() -> void:
	GameState.turn = 0
	GameState.action = 0
	
	$ButtonClickSfx.play()


func _on_to_menu_button_mouse_entered() -> void:
	$ButtonHoverSfx.play()
