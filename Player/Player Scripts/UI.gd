extends CanvasLayer

@onready var money_label = $Control/Money_Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	MoneyManager.player_money_changed.connect(_on_money_changed)
	_on_money_changed(MoneyManager.player_money)
	
func _on_money_changed(money: int):
	money_label.text = "MONEY: " + str(money)
