extends CardEffect

var already_played = false

func on_play(resource: PlayingCard):
	if already_played:
		return
	GameState.change_account_balance(2)
	already_played = true

func on_discard(resource: PlayingCard):
	resource.active_for_n_turns = 0

func on_turn(resource: PlayingCard):
	GameState.change_account_balance(-1)
	resource.active_for_n_turns -= 1
	print("active for ", resource.active_for_n_turns )
	if resource.active_for_n_turns == 0:
		print("credit_period is done")
	
func to_graveyard(resource: PlayingCard) -> bool:
	if resource.active_for_n_turns == 0:
		return true
	print("credit not yet paid")
	return false
