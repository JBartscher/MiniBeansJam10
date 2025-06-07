extends CardEffect

var credit_period = 12
	
func on_sell():
	print("big loan on action")
	
func on_action():
	print("big loan on action")
	
func on_buy():
	print("big loan on buy")
	GameState.change_account_balance(10)

func on_turn():
	print("big loan on turn")
	GameState.change_account_balance(-1)
	credit_period-= 1
	if credit_period == 0:
		print("card is done")
