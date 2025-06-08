extends Control

@export var CardCurveX: Curve
@export var CardCurveY: Curve
@export var CardCurveRot: Curve
@export var HAND_WIDTH: float 

var current_hovered_card: Card
var current_selected_card: Card

const CARD = preload("res://Game/GameObjects/Card/card.tscn")

var draw_card_tween: Tween

func _process(delta: float) -> void:
	if HandController.cards.is_empty():
		$IdleActionButton.visible = true
		$IdleActionButton.disabled = false
	else:
		$IdleActionButton.visible = false
		$IdleActionButton.disabled = true

func _ready() -> void:
	if GameState.first_round:
		add_inital_cards()

	else:
		# recreate cards from last turn
		for c_r in HandController.card_buffer_between_scene_transitition:
			var card:Card = CARD.instantiate()
			card.card_resource = c_r
			HandController.add_card_to_hand(card)
			card.connect("hover", _on_hover_card)
			card.connect("select", _on_select_card)
			add_child(card)
			card.flip_card_to_front()
			HandController.card_buffer_between_scene_transitition = []
		# draw two new cards
		for i in 2:
			draw(i)
	
	SignalBus.refresh_hand.connect(refresh_card_position)
	SignalBus.turn_progressed.connect(_on_turn_progressed)

func _on_turn_progressed():
	# draw two new cards
	for i in 2:
		draw(i)

func add_inital_cards() -> void:
	for i in 6:
		var card_resource = DeckController.get_top_card()
		
		var card:Card = CARD.instantiate()
		card.card_resource = card_resource
		HandController.add_card_to_hand(card)
		card.connect("hover", _on_hover_card)
		card.connect("select", _on_select_card)
		var transform: Transform2D = $Deck.get_transform()
		card.global_position = Vector2(transform.origin)
		add_child(card)
		from_deck_to_hand(card, i*0.1)
		card.flip_card_to_front()
	
	draw_card_tween.tween_callback(refresh_card_position).set_delay(0.15)

func draw(i : int):
	var card:Card = CARD.instantiate()
	var card_resource = DeckController.get_top_card()
	card.card_resource = card_resource.duplicate()
	HandController.add_card_to_hand(card)
	card.connect("hover", _on_hover_card)
	card.connect("select", _on_select_card)
	var transform: Transform2D = $Deck.get_transform()
	card.global_position = Vector2(transform.origin)
	add_child(card)
	from_deck_to_hand(card, i*0.1)
	card.flip_card_to_front()
	
	if not is_inside_tree():
		return
	draw_card_tween.tween_callback(refresh_card_position).set_delay(0.15)

func from_deck_to_hand(card: Card, t: float):
	if not is_inside_tree():
		return
	draw_card_tween = get_tree().create_tween()
	draw_card_tween.chain().tween_property(card, "global_position", self.global_position, 0.2 +t)
	
func _on_hover_card(card: Card):
	if current_hovered_card and current_hovered_card != card:
		current_hovered_card._on_control_mouse_exited()
	current_hovered_card = card	
	
func _on_select_card(card: Card):
	print("select card: ", card)
	current_selected_card = card	

func refresh_card_position():
	var tween = get_tree().create_tween()
	
	for c in HandController.cards:
		if not c:
			continue
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
	
func _on_idle_action_button_pressed() -> void:
	GameState.change_account_balance(-2)
	SignalBus.emit_signal("action_progressed")
