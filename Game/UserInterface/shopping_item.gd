extends PanelContainer

var current_card_resource : PlayingCard

var bought_card = preload("res://Assets/Cards/PlayCardLayoutBack.png")

func init(card_resource: PlayingCard) -> void:
	$MarginContainer/HBox/Name.text = card_resource.name
	$MarginContainer/HBox/Description.text = card_resource.description
	$MarginContainer/HBox/CardLayout/CardPicture.texture = card_resource.texture
	var price_fmt_str = "%s$"
	$MarginContainer/HBox/Price.text = price_fmt_str % card_resource.cost
	current_card_resource = card_resource
	


func _on_buy_button_pressed() -> void:
	GameState.change_account_balance(-current_card_resource.cost)	
	$MarginContainer/HBox/Name.text = " "
	$MarginContainer/HBox/Description.text = "SOLD OUT!"
	$MarginContainer/HBox/CardLayout/CardPicture.texture = null
	$MarginContainer/HBox/CardLayout.texture = bought_card
	$MarginContainer/HBox/Price.text = " "
	
	$MarginContainer/HBox/BuyButton.text = " "
	$MarginContainer/HBox/BuyButton.disabled = true
	
	DeckController.add_card_to_deck(current_card_resource)
