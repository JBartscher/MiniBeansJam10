extends CardEffect

var credit_period = 12
	
func on_play():
	GameState.change_account_balance(10)
	
func on_discard():
	credit_period = 0
	
func on_turn():
	GameState.change_account_balance(-1)
	credit_period-= 1
	if credit_period == 0:
		print("card is done")
	
func to_graveyard() -> bool:
	if credit_period == 0:
		return true
	return false
