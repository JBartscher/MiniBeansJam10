extends Resource
class_name CardEffect

func on_buy():
	print("base buy")
	
func on_play():
	print("base buy")
	
func on_discard():
	print("base sell")
	
func on_action():
	print("base action")
	
func on_turn():
	print("base turn")
	
func to_destroy() -> bool:
	return false
	
func to_graveyard() -> bool:
	return true
	
