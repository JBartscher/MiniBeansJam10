extends CardEffect

var credit_period = 12

func on_buy(resource: PlayingCard):
	GameState.change_account_balance(+4)
	
func on_discard(resource: PlayingCard):
	GameState.change_account_balance(-1)
