extends CardEffect
	
func on_action(resource: PlayingCard):
	GameState.change_account_balance(1)
	if GameState.action < GameState.max_actions:
		SignalBus.emit_signal("action_progressed")
	
func to_graveyard(resource: PlayingCard) -> bool:
	return true

func to_destroy(resource: PlayingCard) -> bool:
	return false
