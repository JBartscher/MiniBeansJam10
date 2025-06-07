extends Node2D

@export var CardCurveX: Curve
@export var CardCurveY: Curve
@export var CardCurveRot: Curve
@export var HAND_WIDTH: float 

var current_hovered_card: Card
var current_selected_card: Card

const CARD = preload("res://Game/GameObjects/Card/card.tscn")

func _ready() -> void:
	_reseize()
	# connect signal that puts our hand in the middle everytime the screen size changes
	get_tree().get_root().size_changed.connect(_reseize)

	HandController.cards = []
	add_cards()
	
	SignalBus.refresh_hand.connect(refresh_card_position)


func add_cards() -> void:
	for i in 4:
		var card_resource = DeckController.get_top_card()
		print(card_resource)
		var card:Card = CARD.instantiate()
		
		card.card_resource = card_resource
		HandController.add_card_to_hand(card)
		card.connect("hover", _on_hover_card)
		card.connect("select", _on_select_card)
		add_child(card)
	refresh_card_position()
	
func _on_hover_card(card: Card):
	# print("hover card: ", card)
	if current_hovered_card and current_hovered_card != card:
		current_hovered_card._on_control_mouse_exited()
	current_hovered_card = card	
	
func _on_select_card(card: Card):
	print("select card: ", card)
	current_selected_card = card	

func refresh_card_position():
	var tween = get_tree().create_tween()
	
	print(HandController)
	print(HandController.cards)
	
	for c in HandController.cards:
		c.global_position = self.global_position
		c.rotation = 0.0
		
		var i = HandController.index_of(c)
		var r = get_card_ratio(i)
		var pos_x = CardCurveX.sample(r) * HAND_WIDTH
		var pos_y = CardCurveY.sample(r) * Vector2.UP * 10
		var card_deg = CardCurveRot.sample(r) * 0.3

		var t = get_card_transform(i)
		# card.transform = t
		tween.parallel().tween_property(c, "transform",t,  0.2)

func get_card_transform(index: int) -> Transform2D:
	var r = get_card_ratio(index)
	var card:Card = HandController.get_card(index)
	
	var t = card.get_transform()
	
	var change_x := CardCurveX.sample(r) * Vector2.LEFT * HAND_WIDTH
	var change_y := CardCurveY.sample(r) * Vector2.UP * 10
	var card_deg = CardCurveRot.sample(r) * 0.3
	
	t = t.rotated(card_deg)
	t = t.translated(change_x)
	t = t.translated(change_y)

	return t
	
func get_card_ratio(index) -> float:
	var hand_ratio = 0.5
	if  len(HandController.cards) > 1:
		hand_ratio = float(index) / float(len(HandController.cards) -1)
	return hand_ratio
	
func _reseize():
	var screen_size = get_viewport_rect().size
	self.position.x = screen_size.x / 2
	self.position.y = screen_size.y * 0.85
	var shape = RectangleShape2D.new()
	shape.size = Vector2(screen_size.x * 0.6, screen_size.y * 0.25)

	#shape.set(" RectangleShape2D.new(200,100)")
	$HandArea/CollisionShape2D.set_shape(shape)
