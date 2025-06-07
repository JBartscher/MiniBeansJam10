extends CardEffect

var credit_period = 12
	
func on_sell():
	GameState.change_account_balance(-4)
	
func on_action():
	print("bad investment on action")
	
func on_buy():
	print("bad investment on buy")

func on_turn():
	print("bad investment on turn")
