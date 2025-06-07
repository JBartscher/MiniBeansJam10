extends CardEffect

var credit_period = 6

func on_sell():
	print("shopping on action")
	
func on_action():
	print("shopping on action")

func on_buy():
	print("shopping on buy")

func on_turn():
	print("go to shop")
