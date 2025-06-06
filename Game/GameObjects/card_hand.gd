extends Node2D

@export var CardCurveX: Curve
@export var CardCurveY: Curve
@export var CardCurveRot: Curve
@export var HAND_WIDTH: float 

var current_hovered_card: Card
var current_selected_card: Card

var cards = {}

const CARD = preload("res://card.tscn")

func add_cards() -> void:
	for i in 15:
		var card:Card = CARD.instantiate()
		cards[i] = card
		card.connect("hover", _on_hover_card)
		card.connect("select", _on_select_card)
		# card.connect("deselect", _on_deselect_card)
		add_child(card)
	refresh_card_position()
	
func _on_hover_card(card: Card):
	# print("hover card: ", card)
	if current_hovered_card and current_hovered_card != card:
		current_hovered_card._on_area_2d_mouse_exited()
	current_hovered_card = card	
	
func _on_select_card(card: Card):
	print("select card: ", card)
	current_selected_card = card	

func refresh_card_position():
	
	var tween = get_tree().create_tween()
	
	for c in cards:
		var r = get_card_ratio(c)
		var card:Node2D = cards[c]
		var pos_x = CardCurveX.sample(r) * HAND_WIDTH
		var pos_y = CardCurveY.sample(r) * Vector2.UP * 10
		var card_deg = CardCurveRot.sample(r) * 0.3

		var t = get_card_transform(c)
		# card.transform = t
		tween.parallel().tween_property(card, "transform",t,  0.2)


func get_card_transform(index: int) -> Transform2D:
	var r = get_card_ratio(index)
	var card:Node2D = cards[index]
	
	var t = card.transform
	
	var change_x := CardCurveX.sample(r) * Vector2.LEFT * HAND_WIDTH
	var change_y := CardCurveY.sample(r) * Vector2.UP * 10
	var card_deg = CardCurveRot.sample(r) * 0.3
	
	t = t.rotated(card_deg)
	t = t.translated(change_x)
	t = t.translated(change_y)
	
	
	return t
	
#func add_card() -> void:
	#var card = CARD.instantiate()
	#cards.append(card)
	#add_child(card)
	#refresh_card_position()
	
func _ready() -> void:
	_reseize()
	# connect signal that puts our hand in the middle everytime the screen size changes
	get_tree().get_root().size_changed.connect(_reseize)

	add_cards()

func get_card_ratio(index) -> float:
	var hand_ratio = 0.5
	if  len(cards) > 1:
		hand_ratio = float(index) / float(len(cards) -1)
		
	return hand_ratio
	
func _reseize():
	var screen_size = get_viewport_rect().size
	self.position.x = screen_size.x / 2
	self.position.y = screen_size.y * 0.8
	var shape = RectangleShape2D.new()
	shape.size = Vector2(screen_size.x * 0.6, screen_size.y * 0.25)

	#shape.set(" RectangleShape2D.new(200,100)")
	$HandArea/CollisionShape2D.set_shape(shape)
