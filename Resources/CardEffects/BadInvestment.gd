extends CardEffect

var credit_period = 12

func on_buy():
	GameState.change_account_balance(+4)
	
func on_discard():
	GameState.change_account_balance(-1)
