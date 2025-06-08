extends ColorRect

var swirl_tween: Tween

var target_color_1: Color
var target_color_2: Color


func _process(delta: float) -> void:
	var lerped_color_1 = lerp(self.material.get("shader_parameter/colour_1"), target_color_1, 0.25 * delta)
	self.material.set("shader_parameter/colour_1", lerped_color_1)
	
	var lerped_color_2 = lerp(self.material.get("shader_parameter/colour_2"), target_color_2, 0.15 * delta)
	self.material.set("shader_parameter/colour_2", lerped_color_2)

func _ready() -> void:
	if not is_inside_tree():
		return
	swirl_tween = get_tree().create_tween()
	swirl_tween.set_trans(Tween.TRANS_LINEAR)
	swirl_tween.set_ease(Tween.EASE_IN_OUT)
	# run infinite
	swirl_tween.set_loops()
	"shader_parameter/spin_amount"
	swirl_tween.tween_property(self, "material:shader_parameter/spin_amount", 0.5, 60.0)
	swirl_tween.chain().tween_property(self, "material:shader_parameter/spin_amount", 0.0, 60.0)
	
	_on_account_balance_changed(0, GameState._account_balance)

	GameState.account_balance_changed.connect(_on_account_balance_changed)
	
func _on_account_balance_changed(old_account_balance: int, new_account_balance: int):
	var balance_ratio: float = new_account_balance / 100.0
	print(balance_ratio)
	
	var color1: Color = self.material.get("shader_parameter/colour_1")
	var color2: Color = self.material.get("shader_parameter/colour_2")
	
	if balance_ratio < 0:
		color1.r = max(color1.r + abs(balance_ratio), 0.5)
		color1.g = 0.3
		color1.b = 0.2
		target_color_1 = color1
		
		color2.r = max(color2.r + (abs(balance_ratio)/ 2), 0.6)
		color2.g = 0.5
		color2.b = 0.3
		target_color_2 = color2
		
	if balance_ratio > 0:
		color1.g = max(color1.g + abs(balance_ratio), 0.5)
		color1.r = 0.35
		color1.b = 0.2
		target_color_1 = color1
		
		color2.g = max(color2.g + (abs(balance_ratio)/ 2), 0.6)
		color2.r = 0.6
		color2.b = 0.3
		target_color_2 = color2
		
