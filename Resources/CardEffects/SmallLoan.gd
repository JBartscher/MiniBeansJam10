extends CardEffect

var credit_period = 6
var already_played = false

func on_play():
	if already_played:
		return
	GameState.change_account_balance(5)
	already_played = true

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
