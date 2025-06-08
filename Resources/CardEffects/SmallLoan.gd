extends CardEffect

var credit_period = 6
	
func on_play():
	GameState.change_account_balance(5)

func on_discard():
	credit_period = 0

func on_turn():
	GameState.change_account_balance(-1)
	credit_period-= 1
	if credit_period == 0:
		print("credit_period is done")
	
func to_graveyard() -> bool:
	if credit_period == 0:
		return true
	print("credit not yet paid")
	return false
