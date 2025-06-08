extends Node2D
class_name Card

@export var card_resource: PlayingCard

var is_selected = false
var is_returning = false
var target_position: Vector2
var target_rotation: float = 0.0

var card_front = preload("res://Assets/Cards/PlayCardLayout.png")
var card_back = preload("res://Assets/Cards/PlayCardLayoutBack.png")

# rotation oscillator
var displacement := 0.0 
var spring := 250.0
var damp := 8.0
var velocity_multiplier: float = 1.2
var oscillator_velocity: float = 0.0

var tween_hover: Tween
var tween_rotation: Tween
var tween_flip: Tween

signal hover(card: Card)
signal select(card: Card)

const PSEUDO_3D = preload("res://Resources/pseudo_3d.tres")

var effect

func _ready() -> void:
	effect = card_resource.card_effect.new()
	$CardName.text = card_resource.name
	$CardDescription.text = card_resource.description
	$BackBufferCopy/CardImage.texture = card_resource.texture
	$BackBufferCopy/CardImage.material = PSEUDO_3D.duplicate(true)
	$BackBufferCopy/CardLayout.material = PSEUDO_3D.duplicate(true)
	
func flip_card_to_front():
	if tween_flip and tween_flip.is_running():
		tween_flip.kill()
	
	var layout : Sprite2D = $BackBufferCopy/CardLayout
	
	tween_flip = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tween_flip.tween_property(layout, "material:shader_parameter/y_rot", -90.0, 0.2)	
	tween_flip.chain().tween_callback(_change_card_layout_texture.bind(card_front))
	tween_flip.chain().tween_property(layout, "material:shader_parameter/y_rot", 90.0, 0.01)
	tween_flip.chain().tween_property(layout, "material:shader_parameter/y_rot", 0.0, 0.2)
	tween_flip.parallel().tween_property($BackBufferCopy/CardImage, "visible", true, 0.2)
	tween_flip.parallel().tween_property($CardName, "visible", true, 0.2)
	tween_flip.parallel().tween_property($CardDescription, "visible", true, 0.2)

func flip_card_to_back():
	$BackBufferCopy/CardImage.visible = false
	$CardName.visible = false
	$CardDescription.visible = false
	
	if tween_flip and tween_flip.is_running():
		tween_flip.kill()
	
	var layout : Sprite2D = $BackBufferCopy/CardLayout
	
	tween_flip = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUART)
	tween_flip.tween_property(layout, "material:shader_parameter/y_rot", 90.0, 0.2)
	tween_flip.chain().tween_callback(_change_card_layout_texture.bind(card_back))
	
	tween_flip.chain().tween_property(layout, "material:shader_parameter/y_rot", -90.0, 0.01)
	tween_flip.chain().tween_property(layout, "material:shader_parameter/y_rot", 0.0, 0.2)
	
func _change_card_layout_texture(texture: Texture2D):
	$BackBufferCopy/CardLayout.texture = texture
	

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

var front = true

func _input(event: InputEvent) -> void:
	if event.is_action_released("click") && is_selected:
		SignalBus.emit_signal("drop_card",self, $Area2D)
		is_selected = false
		is_returning = true
	
	if event.is_action("ui_right"):
		flip_card_to_back()
	if event.is_action("ui_left"):
		flip_card_to_front()
			#flip_card_to_back()
			#front = false
		#else: 
			#flip_card_to_front()
			#front = true

func _on_control_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		is_returning = false
		print("select on ", self.get_canvas_item())
		is_selected = true
		emit_signal("select", self)
		target_position = global_position
		target_rotation = rotation

func _on_control_mouse_entered() -> void:
	emit_signal("hover", self)
	$HoverSfx.play()
	
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
		
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2(1.3,1.3),0.3)
	
	z_index = 10
	
func _on_control_mouse_exited() -> void:
	if is_selected:
		return
	
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(self, "scale", Vector2.ONE, 0.6)
	
	z_index = 0
