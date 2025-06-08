extends CardEffect

var credit_period = 12
	
func on_play():
	var choice = randi() % 2 == 0
	var current_balance = GameState._account_balance
	if current_balance <= 0:
		return
		
	if choice:
		GameState.change_account_balance(current_balance)
	else:
		GameState.change_account_balance(-current_balance)
		
