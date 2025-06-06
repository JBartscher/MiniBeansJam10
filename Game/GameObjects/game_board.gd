extends Node2D

# stage in which the monster is 0 => at top of screen 10 => game over
var stage = 0
@export var end_stage: int= 10

var monster_scale_tween: Tween

var monster_target_pos: Vector2

func _ready() -> void:
	monster_scale_tween = create_tween()
	_reseize()
	# connect signal that puts our hand in the middle everytime the screen size changes
	get_tree().get_root().size_changed.connect(_reseize)
	
	SignalBus.changed_stage.connect(_on_stage_changed)
	
	# self.connect( , _on_stage_changed)

func _process(delta: float) -> void:
	if monster_target_pos:
		var velocity: Vector2 = lerp($Monster.global_position, monster_target_pos, 2.5 * delta)
		$Monster.global_position = velocity

func _reseize():
	var screen_size = get_viewport_rect().size
	$StartPos.position.x = screen_size.x / 2
	$EndPos.position.x = screen_size.x / 2
	$EndPos.position.y = screen_size.y * 0.7

func _on_stage_changed(new_stage: int):
	if(new_stage == end_stage):
		print("last stage reached")
		SignalBus.changed_stage.disconnect(_on_stage_changed)
		return
		
		
	print("stage_changed_to ", new_stage)
	stage = new_stage
	
	var normalized_value = stage / float(end_stage - 1)
	print(normalized_value)
	monster_target_pos = $StartPos.global_position.lerp($EndPos.global_position, normalized_value)
	
	var monster_scale_tween = create_tween()
	if monster_scale_tween and monster_scale_tween.is_running():
		monster_scale_tween.kill()
		
	monster_scale_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	var scale = Vector2.ONE * (1 + (.2 * stage))
	monster_scale_tween.tween_property($Monster, "scale", scale, 0.8)
