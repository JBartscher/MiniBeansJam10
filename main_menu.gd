extends Control


func _ready() -> void:
	$ButtonClickSfx.connect("finished", func(): return get_tree().change_scene_to_file("res://Game/game.tscn"))


func _on_start_button_pressed() -> void:
	$ButtonClickSfx.play()
	

func _on_start_button_mouse_entered() -> void:
	$ButtonHoverSfx.play()
