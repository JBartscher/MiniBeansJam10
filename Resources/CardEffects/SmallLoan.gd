extends CardEffect

var credit_period = 6

func on_sell():
	print("small loan on action")
	
func on_action():
	print("small loan on action")

func on_buy():
	print("small loan on buy")
	GameState.change_account_balance(5)

func on_turn():
	print("small loan on turn")
	GameState.change_account_balance(-1)
	credit_period-= 1
	if credit_period == 0:
		print("card is done")
