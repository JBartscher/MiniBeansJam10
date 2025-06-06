extends Node2D


func _ready() -> void:
	_reseize()
	# connect signal that puts our hand in the middle everytime the screen size changes
	get_tree().get_root().size_changed.connect(_reseize)

func _reseize():
	var screen_size = get_viewport_rect().size
	$StartPosself.position.x = screen_size.x / 2
	$EndPos.position.x = screen_size.x / 2
	$EndPos.position.y = screen_size.y * 0.7
