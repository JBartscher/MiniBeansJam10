extends Node2D
class_name Card

@export var card_resource: PlayingCard

var is_selected = false
var is_returning = false
var target_position: Vector2
var target_rotation: float = 0.0

# rotation oscillator
var displacement := 0.0 
var spring := 250.0
var damp := 8.0
var velocity_multiplier: float = 1.2
var oscillator_velocity: float = 0.0

var tween_hover: Tween
var tween_rotation: Tween

signal hover(card: Card)
signal select(card: Card)
signal deselect(card: Card)

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hover", self)
	
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
		
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2(1.3,1.3),0.3)
	
	z_index = 10

func _on_area_2d_mouse_exited() -> void:
	if is_selected:
		return
	
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2.ONE, 0.6)
	
	z_index = 0


func _physics_process(delta: float) -> void:
	if is_selected:
		var velocity: Vector2 = lerp(global_position, get_global_mouse_position(), 25 * delta)
		var center_screen = (get_viewport_rect().size / 2.0)
		var direction = velocity -  Vector2(center_screen.x, center_screen.y)

		oscillator_velocity += direction.normalized().x * velocity_multiplier
		var force = -spring * displacement - damp * oscillator_velocity
		oscillator_velocity += force * delta
		displacement += oscillator_velocity * delta
		
		rotation = displacement
		global_position = velocity
		
	if is_returning:
		global_position = lerp(global_position, target_position, 5 * delta)
		rotation = lerp(rotation, target_rotation, 5 * delta)

func _input(event: InputEvent) -> void:
	if event.is_action_released("Click") && is_selected:
		is_selected = false
		is_returning = true

func _on_control_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("Click"):
		is_returning = false
		print("select on ", self.get_canvas_item())
		is_selected = true
		emit_signal("select", self)
		target_position = global_position
		target_rotation = rotation
