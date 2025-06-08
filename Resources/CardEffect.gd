extends Resource
class_name CardEffect

func on_buy(resource: PlayingCard):
	print("base buy")
	
func on_play(resource: PlayingCard):
	print("base buy")
	
func on_discard(resource: PlayingCard):
	print("base sell")
	
func on_action(resource: PlayingCard):
	print("base action")
	
func on_turn(resource: PlayingCard):
	print("base turn")
	
func to_destroy(resource: PlayingCard) -> bool:
	return false
	
func to_graveyard(resource: PlayingCard) -> bool:
	return true
	
