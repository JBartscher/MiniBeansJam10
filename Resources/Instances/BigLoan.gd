extends PlayingCard

var credit_period = 6

func on_buy():
	GameState.change_account_balance(5)

func on_turn():
	GameState.change_account_balance(-1)
	credit_period-= 1
	if credit_period == 0:
		print("card is done")
