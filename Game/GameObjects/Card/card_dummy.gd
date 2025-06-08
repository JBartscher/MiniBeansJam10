extends Node2D
class_name DummyCard

@export var card_resource: PlayingCard

var card_back = preload("res://Assets/Cards/PlayCardLayoutBack.png")
var tween_flip: Tween

func _ready() -> void:
	$CardName.text = card_resource.name
	$CardDescription.text = card_resource.description
	$CardImage.texture = card_resource.texture

func flip_card_to_back():
	$CardImage.visible = false
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
	$CardLayout.texture = texture
